<?php
class ModelLocalisationLocation extends Model {
	public function getLocation($location_id) {
		$query = $this->db->query("SELECT location_id, name, address, geocode, telephone, fax, image, open, comment FROM " . DB_PREFIX . "location WHERE location_id = '" . (int)$location_id . "'");

		return $query->row;
	}

	public function getCities($area) {

	    $area = $this->db->escape($area);

            $sql = "SELECT *, c.DescriptionRu AS name, c.Ref AS ref FROM " . DB_PREFIX . "cities c";

            if ( !empty($this->session->data['shipping_method']['sql_db']) ) {
                $sql_db = $this->session->data['shipping_method']['sql_db'];
                $sql .= " LEFT JOIN " . DB_PREFIX . $sql_db . " wr ON (c.Ref = wr.CityRef)" ;
            }

            $sql .= " WHERE c.Area = '" . $this->db->escape($area) . "' ";
            if ( !empty($this->session->data['shipping_method']['sql_db']) ) {
                $sql .= " AND wr.id IS NOT NULL GROUP BY c.id";
            }
            $sql .= " ORDER BY name";

            $query = $this->db->query($sql);

            $cities_data = $query->rows;

        return $cities_data;
    }

	public function getWarehouseByCity($ref, $sql_db = false) {
        $ref = $this->db->escape($ref);
        $sql_db = $this->db->escape($sql_db);
        $warehouse_data = $this->cache->get($sql_db.'.' . $ref);

        if (!$warehouse_data) {
            $query = $this->db->query("SELECT *, DescriptionRu AS name, Ref AS ref FROM " . DB_PREFIX . $sql_db . " WHERE CityRef = '" . $this->db->escape($ref) . "' ORDER BY name");

            $warehouse_data = $query->rows;

            $this->cache->set('novaposhta.warehouse.' . $ref, $warehouse_data);
        }

        return $warehouse_data;
    }

}