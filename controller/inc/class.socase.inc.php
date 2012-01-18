<?php
	/**
	* phpGroupWare - controller: a part of a Facilities Management System.
	*
	* @author Erink Holm-Larsen <erik.holm-larsen@bouvet.no>
	* @author Torstein Vadla <torstein.vadla@bouvet.no>
	* @copyright Copyright (C) 2011,2012 Free Software Foundation, Inc. http://www.fsf.org/
	* This file is part of phpGroupWare.
	*
	* phpGroupWare is free software; you can redistribute it and/or modify
	* it under the terms of the GNU General Public License as published by
	* the Free Software Foundation; either version 2 of the License, or
	* (at your option) any later version.
	*
	* phpGroupWare is distributed in the hope that it will be useful,
	* but WITHOUT ANY WARRANTY; without even the implied warranty of
	* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	* GNU General Public License for more details.
	*
	* You should have received a copy of the GNU General Public License
	* along with phpGroupWare; if not, write to the Free Software
	* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
	*
	* @license http://www.gnu.org/licenses/gpl.html GNU General Public License
	* @internal Development of this application was funded by http://www.bergen.kommune.no/
	* @package property
	* @subpackage controller
 	* @version $Id: class.socheck_item.inc.php 8535 2012-01-09 10:14:45Z vator $
	*/

	phpgw::import_class('controller.socommon');

	include_class('controller', 'check_item_case', 'inc/model/');

	class controller_socase extends controller_socommon
	{
		protected static $so;

		/**
		 * Get a static reference to the storage object associated with this model object
		 *
		 * @return controller_socontrol_group the storage object
		 */
		public static function get_instance()
		{
			if (self::$so == null) {
				self::$so = CreateObject('controller.socase');
			}
			return self::$so;
		}

		function get_query(string $sort_field, boolean $ascending, string $search_for, string $search_type, array $filters, boolean $return_count){}

		function populate(int $object_id, &$object){}

		public function get_single($case_id)
		{
			$sql = "SELECT * FROM controller_check_item_case "; 
			$sql .= "WHERE id = $case_id";
			

			$this->db->limit_query($sql, 0, __LINE__, __FILE__, 1);

			if($this->db->next_record()) {
				$case = new controller_check_item_case($this->unmarshal($this->db->f('id', true), 'int'));
				$case->set_check_item_id($this->unmarshal($this->db->f('check_item_id', true), 'int'));
				$case->set_status($this->unmarshal($this->db->f('status', true), 'int'));
				$case->set_location_id($this->unmarshal($this->db->f('location_id', true), 'int'));
				$case->set_location_item_id($this->unmarshal($this->db->f('location_item_id', true), 'int'));
				$case->set_descr($this->unmarshal($this->db->f('descr', true), 'string'));
				$case->set_user_id($this->unmarshal($this->db->f('user_id', true), 'int'));	
				$case->set_entry_date($this->unmarshal($this->db->f('entry_date', true), 'int'));
				$case->set_modified_date($this->unmarshal($this->db->f('modified_date', true), 'int'));
				$case->set_modified_by($this->unmarshal($this->db->f('modified_by', true), 'int'));
					
				return $case;
			}
			else
			{
				return null;
			}
		}
		
		public function get_cases_by_message($message_ticket_id, $return_type = "return_object")
		{
			$sql = "SELECT * FROM controller_check_item_case "; 
			$sql .= "WHERE location_item_id = $message_ticket_id";

			$this->db->query($sql);

			while ($this->db->next_record()) {
				$case = new controller_check_item_case($this->unmarshal($this->db->f('id', true), 'int'));
				$case->set_check_item_id($this->unmarshal($this->db->f('check_item_id', true), 'int'));
				$case->set_location_id($this->unmarshal($this->db->f('location_id', true), 'int'));
				$case->set_location_item_id($this->unmarshal($this->db->f('location_item_id', true), 'int'));
				$case->set_descr($this->unmarshal($this->db->f('descr', true), 'string'));
				$case->set_user_id($this->unmarshal($this->db->f('user_id', true), 'int'));	
				$case->set_entry_date($this->unmarshal($this->db->f('entry_date', true), 'int'));
				$case->set_modified_date($this->unmarshal($this->db->f('modified_date', true), 'int'));
				$case->set_modified_by($this->unmarshal($this->db->f('modified_by', true), 'int'));

				if($return_type == "return_object")
					$cases_array[] = $case;
				else
					$cases_array[] = $case->toArray();
			}

			return $cases_array;
		}
		
		
		function add(&$case)
		{
			$cols = array(
					'check_item_id',
					'status',
					'location_id',
					'location_item_id',
					'descr',
					'user_id',
					'entry_date',
					'modified_date',
					'modified_by',
			);

			$values = array(
				$this->marshal($case->get_check_item_id(), 'int'),
				$case->get_status(),
				$this->marshal($case->get_location_id(), 'int'),
				$this->marshal($case->get_location_item_id(), 'int'),
				$this->marshal($case->get_descr(), 'string'),
				$this->marshal($case->get_user_id(), 'int'),
				$this->marshal($case->get_entry_date(), 'int'),
				$this->marshal($case->get_modified_date(), 'int'),
				$this->marshal($case->get_modified_by(), 'int')
			);

			$result = $this->db->query('INSERT INTO controller_check_item_case (' . join(',', $cols) . ') VALUES (' . join(',', $values) . ')', __LINE__,__FILE__);

			return isset($result) ? $this->db->get_last_insert_id('controller_check_item_case', 'id') : 0;
		}

		function update($case)
		{
			$id = $case->get_id();
			
			$values = array(
				'check_item_id = ' . $this->marshal($case->get_check_item_id(), 'int'),
				'status = ' . $case->get_status(),
				'location_id = ' . $this->marshal($case->get_location_id(), 'int'),
				'location_item_id = ' . $this->marshal($case->get_location_item_id(), 'int'),
				'descr = ' . $this->marshal($case->get_descr(), 'string'),
				'user_id = ' . $this->marshal($case->get_user_id(), 'int'),
				'entry_date = ' . $this->marshal($case->get_entry_date(), 'int'),
				'modified_date = ' . $this->marshal($case->get_modified_date(), 'int'),
				'modified_by = ' . $this->marshal($case->get_modified_by(), 'int'),
			);

			$result = $this->db->query('UPDATE controller_check_item_case SET ' . join(',', $values) . " WHERE id=$id", __LINE__,__FILE__);

			if( isset($result) )
			{
				return $id;
			}
			else
			{
				return 0;
			}
		}
		
		function get_id_field_name(){}
	}
