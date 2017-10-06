<?php
class ModelCheckoutShipping extends Model {

    public function getCountries($data = array()) {
//        $country_data = $this->cache->get('country.status'. $data['filter_name'] .'');

//        if (!$country_data) {
            $sql = "SELECT * FROM `" . DB_PREFIX . "country`";

            if (!empty($data['filter_name'])) {
                $sql .= " WHERE status = '1' AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }

            $sort_data = array(
                'name',
                'sort_order'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            $country_data = $query->rows;

//            $this->cache->set('country.status'. $data['filter_name'] .'', $country_data);
//        }

        return $country_data;
    }

    public function getZones($data = array()) {
        $sql = "SELECT * FROM `" . DB_PREFIX . "zone`";

        if (!empty($data['country_id'])) {
            $sql .= " WHERE status = '1' AND country_id = '" . (int)$data['country_id'] . "'";


            if (!empty($data['filter_name'])) {
                $sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }


            $sort_data = array(
                'name',
                'sort_order'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            return false;
        }
    }

    public function getCities($data = array()) {

        $sql = "SELECT *, DescriptionRu as name, Ref as ref FROM `" . DB_PREFIX . "cities`";

        if (!empty($data['country_id'])) {
            $sql .= " WHERE Area = '" . (int)$data['area'] . "'";


            if (!empty($data['filter_name'])) {
                $sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }


            $sort_data = array(
                'name'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            return false;
        }
    }

    public function getWarehouseByCity($data = array()) {
        $sql = "SELECT *, DescriptionRu as name, Ref as ref FROM `" . DB_PREFIX . $data['sql_db'] . "`";

        if (!empty($data['country_id'])) {
            $sql .= " WHERE CityRef = '" . (int)$data['ref'] . "'";


            if (!empty($data['filter_name'])) {
                $sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
            }


            $sort_data = array(
                'name'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 25;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            return false;
        }
    }
    
}