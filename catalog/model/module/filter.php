<?php
class ModelModuleFilter extends Model {
    
    public function getFilterOptions($data = array()){
        
        $sql = "SELECT od.option_id,od.name FROM ". DB_PREFIX ."product_option po 
                LEFT JOIN ". DB_PREFIX ."option_description od ON(po.option_id = od.option_id)
                LEFT JOIN ". DB_PREFIX ."option o ON(o.option_id = po.option_id) ";
        
        if (!empty($data['filter_name'])){
            $sql .= "LEFT JOIN ". DB_PREFIX ."product_description pd ON(pd.product_id = p2c.product_id) ";
        }
        
        if (!empty($data['filter_category_id'])) {
            $sql .= "LEFT JOIN ". DB_PREFIX ."product_to_category p2c ON(p2c.product_id = po.product_id) ";
        }
        
        $sql .= "WHERE od.language_id = '".(int)$this->config->get('config_language_id')."' AND o.`type` IN('radio','select','checkbox','image')";
        
        if (!empty($data['filter_category_id'])) {
            $sql .= " AND p2c.category_id = '".(int)$data['filter_category_id']."'";
        }
        
        if (!empty($data['filter_name'])){
            $sql .= " AND (";
            $implode = array();

            $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

            foreach ($words as $word) {
                    $implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
            }

            if ($implode) {
                    $sql .= " " . implode(" AND ", $implode) . "";
            }

            if (!empty($data['filter_description'])) {
                    $sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
            }
        }
        
            $sql .= " GROUP BY od.option_id";
            
            var_dump($sql);
        
        
            $query_opt = $this->db->query($sql);
            
            $filter_options = array();
            
            foreach($query_opt->rows as $option){
                $filter_options_value = array();
                $option_value = $this->getFilterOptionsValue($data,$option['option_id']);
                foreach($option_value as $value){
                    $filter_options_value[] = array(
                        'option_value_id' => $value['option_value_id'],
                        'name'            => $value['name'],
                    );
                }
                
                $filter_options[] = array(
                    'option_id' => $option['option_id'],
                    'option_name' => $option['name'],
                    'option_value' => $filter_options_value
                );
                
            }
            
            return $filter_options;
              
    }
    
    public function getFilterOptionsValue($data = array(),$option_id){
            $sql_val = "SELECT DISTINCT pov.option_value_id,ovd.name FROM ". DB_PREFIX ."product_option_value pov 
                            LEFT JOIN ". DB_PREFIX ."option_value_description ovd ON(pov.option_value_id = ovd.option_value_id)";
            
            if (!empty($data['filter_category_id'])) {
                $sql_val .= "LEFT JOIN ". DB_PREFIX ."product_to_category p2c ON (p2c.product_id = pov.product_id) ";
            }
            
            if (!empty($data['filter_name'])){
                $sql_val .= "LEFT JOIN ". DB_PREFIX ."product_description pd ON(pd.product_id = p2c.product_id) ";
            }
            
             $sql_val .= "WHERE ovd.language_id = '".(int)$this->config->get('config_language_id')."'";

             $sql_val .= " AND pov.option_id = '".(int)$option_id."'";

             if (!empty($data['filter_category_id'])) {
                $sql_val .= " AND p2c.category_id = '".(int)$data['filter_category_id']."'";
             }
                 
             if (!empty($data['filter_name'])){
                    $sql_val .= " AND (";
                    $implode = array();

                    $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

                    foreach ($words as $word) {
                            $implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
                    }

                    if ($implode) {
                            $sql_val .= " " . implode(" AND ", $implode) . "";
                    }

                    if (!empty($data['filter_description'])) {
                            $sql_val .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                    }
            } 
            
            $query = $this->db->query($sql_val);
            
            return $query->rows;
        
    }
        
    
    
}