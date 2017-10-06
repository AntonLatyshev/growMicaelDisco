<?php
/*
 * Products series
 * Add posibility to link product to product
 * This used in fornt product/product tpl
 * Methods to get product series and products by series placed in front catalog/product model 
 * */
class ModelCatalogSeries extends Model {
	
	/*
	 * Create empty series
	 * */
	public function addSeries($name = '') {
		if(!$name) {
			$sql = "Select count(*) as quantity From " . DB_PREFIX . "series";
			$qu = $this->db->query($sql);
			$new_quantity = $qu->row['quantity'] + 1; 
			$name = 'unnamed_' . $new_quantity;
		}

		$sql = "SELECT series_id FROM " . DB_PREFIX . "series WHERE name = '{$this->db->escape($name)}'";
		$exists = $this->db->query($sql);
		if($exists->num_rows) {
			return false;
		}

		$sql = "INSERT INTO " . DB_PREFIX . "series SET name = '" . $this->db->escape($name) . "'";
		$this->db->query($sql);
		$series_id = $this->db->getLastId();
		
		return $series_id;
	}
	
	/*
	 * Delete series and unlink all products from it
	 * */
	public function deleteSeries($series_id) {
		$sql = "DELETE FROM " . DB_PREFIX . "series WHERE series_id = " . (int)$series_id;
		$this->db->query($sql);
                $sql = "SELECT product_id FROM " . DB_PREFIX . "product_to_series WHERE series_id = " . (int)$series_id;
                $query = $this->db->query($sql);
                foreach ($query->rows as $value) {
                    if (isset($value['product_id']) && $value['product_id']) {
                            $this->db->query("UPDATE " . DB_PREFIX . "product SET in_series = '0' WHERE product_id = '" . (int)$value['product_id'] . "'");
                    }                    
                }
                
		$sql = "DELETE FROM " . DB_PREFIX . "product_to_series WHERE series_id = " . (int)$series_id;
		$this->db->query($sql);
		
		return true;
	}
	
	/*
	 * Add product series and create it if not exists
	 * */
	public function addProductToSeries($product_id, $series_name) {
		$sql = "SELECT * FROM " . DB_PREFIX . "series WHERE name = '" . $this->db->escape($series_name) . "'";
		$series = $this->db->query($sql);
		if($series->num_rows) {
			$series_id = $series->row['series_id'];
		} else {
			$sql = "INSERT INTO " . DB_PREFIX . "series SET name = '{$this->db->query($series_name)}';";
			$series = $this->db->query($sql);
			$series_id = $this->db->getLastId();
		}
		/* Check if product exists in this series */
		$sql = "SELECT product_id FROM " . DB_PREFIX . "product_to_series WHERE product_id = " . (int)$product_id . " AND series_id = " . (int)$series_id . "";
		$exists = $this->db->query($sql);
		if($exists->num_rows) {
			return false;
		}
		$sql = "INSERT INTO " . DB_PREFIX . "product_to_series SET product_id = " . (int)$product_id . ", series_id = " . (int)$series_id . "";
		$this->db->query($sql);
		$link_id = $this->db->getLastId();
		
		return $link_id;
	}
	/*
	 * Add product series by id
	 * */
	public function addProductToSeriesById($product_id, $series_id) {
		$sql = "SELECT * FROM " . DB_PREFIX . "series WHERE series_id = '" . (int)$series_id . "'";
		$series = $this->db->query($sql);
		if(!$series->num_rows) {
			return false;
		} else {
			/* Check if product exists in this series */
			$sql = "SELECT	product_id FROM " . DB_PREFIX . "product_to_series WHERE product_id = '" . (int)$product_id . "' AND series_id = '" . (int)$series_id . "'";
			$exists = $this->db->query($sql);
			if($exists->num_rows) {
				return false;
			}
			$sql = "INSERT INTO " . DB_PREFIX . "product_to_series SET product_id = '" . (int)$product_id . "',	series_id = '" . (int)$series_id . "'";
			$this->db->query($sql);
			$link_id = $this->db->getLastId();
                        
			$this->db->query("UPDATE " . DB_PREFIX . "product SET in_series = '1' WHERE product_id = '" . (int)$product_id . "'");
			
                        return $link_id;
		}	
	}
	
	/*
	 * Remove product From series
	 * */
	public function deleteProductFromSeries($product_id, $series_id) {
		$sql = "DELETE FROM " . DB_PREFIX . "product_to_series	WHERE product_id = '" . (int)$product_id . "' AND series_id = '" . (int)$series_id . "'";
		$this->db->query($sql);
		$this->db->query("UPDATE " . DB_PREFIX . "product SET in_series = '0' WHERE product_id = '" . (int)$product_id . "'");
                
		return true;
	}
	
	/*
	 * Get all product in target series
	 * */
	public function getSeriesProducts($series_id) {
		$sql = "SELECT product_id, is_main FROM " . DB_PREFIX . "product_to_series WHERE series_id = " . (int)$series_id;

		$products_id = $this->db->query($sql);
		if($products_id->num_rows) {

			$products = array();
			$this->load->model('catalog/product');
			$this->load->model('catalog/category');
			$i = 0;

			foreach ($products_id->rows as $product_id) {
				$products[$i] = $this->model_catalog_product->getProduct($product_id['product_id']);
				$products[$i]['manufacturer'] = $this->model_catalog_product->getManufacturerById($products[$i]['manufacturer_id']);

				$categories = $this->model_catalog_product->getProductCategories($product_id['product_id']);
				$category_id = array_pop($categories);
				$category_name = $this->getCategoryDescriptions($category_id);

				if (isset($category_name)) {
					$products[$i]['category'] = $category_name['name'];
				} else {
					$products[$i]['category'] = "";
				}

				$products[$i]['is_main'] = $product_id['is_main'];
				$i++;
			}

			return $products;
		} else {
			return array();
		}
	}
	
	/*
	 * Get all series
	 * */
	public function getSeries($series_id = 0) {
		
		$sql = "SELECT * FROM " . DB_PREFIX . "series";
		if($series_id) {
			$sql .= " WHERE series_id = " . (int)$series_id;	
		}
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			if($series_id) {
				return $series->row;
			} else {
				return $series->rows;
			}
		} else {
			return array();
		}
	}
	
	/*
	 * Get series id and name by product id
	 * */
	public function getProductSeries($product_id) {
		$sql = "SELECT * FROM " . DB_PREFIX . "product_to_series p2se LEFT JOIN " . DB_PREFIX . "series s ON (s.series_id = p2se.series_id) WHERE p2se.product_id = '" . (int)$product_id . "'";
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			return $series->row;
		} else {
			return array();
		}
	}
	
	/*
	 * Return series by part of name 
	 * Created for autocomplete
	 * */
	public function getSeriesByName($series_name) {
		$sql = "SELECT * FROM " . DB_PREFIX . "series WHERE name Like ('%{$this->db->escape($series_name)}%')";
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			return $series->rows;
		} else {
			return array();
		}
	}

    public function changeMainProduct($product_id, $series_id) {
        if($product_id && $series_id) {
            //get main product in the series
            $query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product_to_series WHERE series_id = '" . (int)$series_id . "' AND is_main = '1' LIMIT 1");
            $product_1 = $query->row['product_id'];
            if(isset($product_1) && $product_1){
                $this->db->query("UPDATE " . DB_PREFIX . "product SET in_series = '1' WHERE product_id = '" . (int)$product_1 . "'");
            }
            
            $sql = "UPDATE " . DB_PREFIX . "product_to_series SET is_main = '0' WHERE series_id = '" . (int)$series_id . "'";
            $this->db->query($sql);
            
            $sql = "UPDATE " . DB_PREFIX . "product_to_series SET is_main = '1' WHERE series_id = '" . (int)$series_id . "' AND product_id = '" . (int)$product_id . "'";
            $this->db->query($sql);
            
            $this->db->query("UPDATE " . DB_PREFIX . "product SET in_series = '0' WHERE product_id = '" . (int)$product_id . "'");
			
        }

        return true;
    }

	public function getCategoryDescriptions($category_id) {
		$category_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");

		foreach ($query->rows as $result) {
			$category_description_data = array(
				'name'              => $result['name'],
				'meta_title'        => $result['meta_title'],
				'meta_description'  => $result['meta_description'],
				'meta_keyword'      => $result['meta_keyword'],
				'description'       => $result['description'],
				'description_short' => $result['description_short']
			);
		}

		return $category_description_data;
	}

}
?>
