<?php
class ModelExtensionModule extends Model {
	public function addModule($code, $data) {
            if(isset($data['custom_field'])){
                 unset($data['custom_field']);
            }
                
		$this->db->query("INSERT INTO `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `code` = '" . $this->db->escape($code) . "', `setting` = '" . $this->db->escape(serialize($data)) . "'");
	}
	
	public function editModule($module_id, $data) {
            
            if(!empty($data['custom_field'])){
                $custom_field = json_encode($data['custom_field'], JSON_UNESCAPED_UNICODE);
                $sql = ",custom_field = '".$this->db->escape($custom_field)."'";
            }else{
                $custom_field = false;
                $sql = ",custom_field = ''";
            }
            
		$this->db->query("UPDATE `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `setting` = '" . $this->db->escape(serialize($data)) . "'$sql WHERE `module_id` = '" . (int)$module_id . "'");
	}

	public function deleteModule($module_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "module` WHERE `module_id` = '" . (int)$module_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "layout_module` WHERE `code` LIKE '%." . (int)$module_id . "'");
	}
		
	public function getModule($module_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `module_id` = '" . $this->db->escape($module_id) . "'");

		if ($query->row) {
			return unserialize($query->row['setting']);
		} else {
			return array();	
		}
	}
	
	public function getModules() {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` ORDER BY `code`");

		return $query->rows;
	}	
		
	public function getModulesByCode($code) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = '" . $this->db->escape($code) . "' ORDER BY `name`");

		return $query->rows;
	}	
	
	public function deleteModulesByCode($code) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "module` WHERE `code` = '" . $this->db->escape($code) . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "layout_module` WHERE `code` LIKE '" . $this->db->escape($code) . "' OR `code` LIKE '" . $this->db->escape($code . '.%') . "'");
	}
        
        public function getModuleCustomFields($module_id) {
		$query = $this->db->query("SELECT custom_field FROM " . DB_PREFIX . "module WHERE module_id = '" . (int)$module_id . "'");

		return $query->row['custom_field'];
	}

	public function editCustomFields($module_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "module SET custom_field = '" . $this->db->escape($data) . "' WHERE module_id = '" . (int)$module_id . "'");

	}
}