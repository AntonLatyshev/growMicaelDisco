<?php
class ModelSaleNovaposhta extends Model {

    public function getCountCities() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cities");

        return $query->row['total'];
    }

    public function getCountWarehouses() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "novaposhta_warehouses");

        return $query->row['total'];
    }

    public function updateCities($data) {

        $this->db->query("DELETE FROM " . DB_PREFIX . "cities");

        foreach ($data as $item) {
            if ( isset($item['CityID']) ) {

                // $cityID = (int)$item['CityID'];

                // $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "cities WHERE CityID = '" . (int)$cityID . "'");

                /* if ($query->num_rows) {
                    $this->db->query("UPDATE " . DB_PREFIX . "cities SET 
                        Description = '" . $this->db->escape($item['Description']) . "', 
                        DescriptionRu = '" . $this->db->escape($item['DescriptionRu']) . "', 
                        Ref = '" . $this->db->escape($item['Ref']) . "', 
                        Area = '" . $this->db->escape($item['Area']) . "', 
                        Delivery1 = '" . $this->db->escape($item['Delivery1']) . "', 
                        Delivery2 = '" . $this->db->escape($item['Delivery2']) . "', 
                        Delivery3 = '" . $this->db->escape($item['Delivery3']) . "', 
                        Delivery4 = '" . $this->db->escape($item['Delivery4']) . "', 
                        Delivery5 = '" . $this->db->escape($item['Delivery5']) . "', 
                        Delivery6 = '" . $this->db->escape($item['Delivery6']) . "', 
                        Delivery7 = '" . $this->db->escape($item['Delivery7']) . "', 
                        Conglomerates = '' 
                    WHERE 
                        CityID = '" . (int)$cityID . "'
                    ");
                } else { */

                    $this->db->query("INSERT INTO " . DB_PREFIX . "cities SET 
                        Description = '" . $this->db->escape($item['Description']) . "', 
                        DescriptionRu = '" . $this->db->escape($item['DescriptionRu']) . "', 
                        Ref = '" . $this->db->escape($item['Ref']) . "', 
                        Area = '" . $this->db->escape($item['Area']) . "', 
                        Delivery1 = '" . $this->db->escape($item['Delivery1']) . "', 
                        Delivery2 = '" . $this->db->escape($item['Delivery2']) . "', 
                        Delivery3 = '" . $this->db->escape($item['Delivery3']) . "', 
                        Delivery4 = '" . $this->db->escape($item['Delivery4']) . "', 
                        Delivery5 = '" . $this->db->escape($item['Delivery5']) . "', 
                        Delivery6 = '" . $this->db->escape($item['Delivery6']) . "', 
                        Delivery7 = '" . $this->db->escape($item['Delivery7']) . "', 
                        Conglomerates = '', 
                        CityID = '" . $this->db->escape($item['CityID']) . "'
                    ");
                // }
            }
        }
    }

    public function updateWarehouses($data) {

        $this->db->query("DELETE FROM " . DB_PREFIX . "novaposhta_warehouses");

        foreach ($data as $item) {
            if ( isset($item['SiteKey']) ) {

                /* $siteKey = (int)$item['SiteKey'];

                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "novaposhta_warehouses WHERE SiteKey = '" . (int)$siteKey . "'");

                if ($query->num_rows) {
                    $this->db->query("UPDATE " . DB_PREFIX . "novaposhta_warehouses SET 
                        Description     = '" . $this->db->escape($item['Description']) . "', 
                        DescriptionRu   = '" . $this->db->escape($item['DescriptionRu']) . "', 
                        Phone           = '" . $this->db->escape($item['Phone']) . "', 
                        TypeOfWarehouse = '" . $this->db->escape($item['TypeOfWarehouse']) . "', 
                        Ref             = '" . $this->db->escape($item['Ref']) . "', 
                        Number          = '" . $this->db->escape($item['Number']) . "', 
                        CityRef         = '" . $this->db->escape($item['CityRef']) . "', 
                        CityDescription     = '" . $this->db->escape($item['CityDescription']) . "', 
                        CityDescriptionRu   = '" . $this->db->escape($item['CityDescriptionRu']) . "', 
                        Longitude       = '" . $this->db->escape($item['Longitude']) . "', 
                        Latitude        = '" . $this->db->escape($item['Latitude']) . "', 
                        PostFinance     = '" . $this->db->escape($item['PostFinance']) . "', 
                        BicycleParking  = '" . $this->db->escape($item['BicycleParking']) . "', 
                        POSTerminal     = '" . $this->db->escape($item['POSTerminal']) . "', 
                        TotalMaxWeightAllowed = '" . $this->db->escape($item['TotalMaxWeightAllowed']) . "', 
                        PlaceMaxWeightAllowed = '" . $this->db->escape($item['PlaceMaxWeightAllowed']) . "', 
                        Reception       = '" . $this->db->escape($item['Reception']) . "', 
                        Delivery        = '" . $this->db->escape($item['Delivery']) . "', 
                        Schedule        = '" . $this->db->escape($item['Schedule']) . "'
                    WHERE 
                        SiteKey         = '" . (int)$siteKey . "'
                    ");
                } else { */

                    $this->db->query("INSERT INTO " . DB_PREFIX . "novaposhta_warehouses SET 
                        SiteKey         = '" . (int)$item['SiteKey'] . "', 
                        Description     = '" . $this->db->escape($item['Description']) . "', 
                        DescriptionRu   = '" . $this->db->escape($item['DescriptionRu']) . "', 
                        Phone           = '" . $this->db->escape($item['Phone']) . "', 
                        TypeOfWarehouse = '" . $this->db->escape($item['TypeOfWarehouse']) . "', 
                        Ref             = '" . $this->db->escape($item['Ref']) . "', 
                        `Number`        = '" . $this->db->escape($item['Number']) . "', 
                        CityRef         = '" . $this->db->escape($item['CityRef']) . "', 
                        CityDescription     = '" . $this->db->escape($item['CityDescription']) . "', 
                        CityDescriptionRu   = '" . $this->db->escape($item['CityDescriptionRu']) . "', 
                        Longitude       = '" . $this->db->escape($item['Longitude']) . "', 
                        Latitude        = '" . $this->db->escape($item['Latitude']) . "', 
                        PostFinance     = '" . $this->db->escape($item['PostFinance']) . "', 
                        BicycleParking  = '" . $this->db->escape($item['BicycleParking']) . "', 
                        POSTerminal     = '" . $this->db->escape($item['POSTerminal']) . "', 
                        TotalMaxWeightAllowed = '" . $this->db->escape($item['TotalMaxWeightAllowed']) . "', 
                        PlaceMaxWeightAllowed = '" . $this->db->escape($item['PlaceMaxWeightAllowed']) . "', 
                        Reception       = '" . $this->db->escape($item['Reception']) . "', 
                        Delivery        = '" . $this->db->escape($item['Delivery']) . "', 
                        Schedule        = '" . $this->db->escape($item['Schedule']) . "'
                    ");
                // }
            }
        }
    }

}