<?php
	/**
	* jsCalendar wrapper-class
	*
	* @author Ralf Becker <RalfBecker@outdoor-training.de>
	* @copyright Copyright (C) 2003,2004 Free Software Foundation, Inc. http://www.fsf.org/
	* @license http://www.fsf.org/licenses/gpl.html GNU General Public License
	* @package phpgwapi
	* @subpackage gui
	* @version $Id: class.jscalendar.inc.php 17882 2007-01-14 11:10:08Z skwashd $
	*/

	/**
	* jsCalendar wrapper-class
	*
	* @package phpgwapi
	* @subpackage gui
	* @internal The constructor load the necessary javascript-files
	*/
	class jscalendar
	{
		/**
		 * @author ralfbecker
		 * constructor of the class
		*
		 * @param $do_header if true, necessary javascript and css gets loaded, only needed for input
		 */
		function jscalendar($do_header=True)
		{
			if(!is_object($GLOBALS['phpgw']->js))
			{
				$GLOBALS['phpgw']->js = createObject('phpgwapi.javascript');
			}
			$GLOBALS['phpgw']->js->validate_file('jscalendar', 'calendar_stripped');
			$this->phpgw_js_url = $GLOBALS['phpgw_info']['server']['webserver_url'].'/phpgwapi/js';
			$this->dateformat = $GLOBALS['phpgw_info']['user']['preferences']['common']['dateformat'];

			if ($do_header && (!isset($GLOBALS['phpgw_info']['flags']['css']) || 
				(isset($GLOBALS['phpgw_info']['flags']['css']) && !strstr($GLOBALS['phpgw_info']['flags']['css'],'jscalendar') ) ) )
			{
				if ( !isset($GLOBALS['phpgw_info']['flags']['css']) )
				{
					$GLOBALS['phpgw_info']['flags']['css'] = '';
				}
				$GLOBALS['phpgw_info']['flags']['css'] .= "\n</style>\n"
					. '<link rel="stylesheet" type="text/css" media="all" href="'
					. $this->phpgw_js_url
					. '/jscalendar/calendar-win2k-cold-1.css" title="win2k-cold-1" />'
					. "\n<style type=\"text/css\">\n";

				if ( !isset($GLOBALS['phpgw_info']['flags']['java_script']) )
				{
					$GLOBALS['phpgw_info']['flags']['java_script'] = '';
				}
				$GLOBALS['phpgw_info']['flags']['java_script'] .= "\n"
					. '<script type="text/javascript" src="'
					. $GLOBALS['phpgw']->link('/phpgwapi/js/jscalendar/jscalendar-setup.php')
					."\">\n</script>\n";
			}
		}

		function add_listener($name)
		{
			$this->_input_modern($name);
		}

		/**
		 * @author ralfbecker
		 * creates an inputfield for the jscalendar (returns the necessary html and js)
		*
		 * @param $name name and id of the input-field (it also names the id of the img $name.'-toggle')
		 * @param $date date as string or unix timestamp (in users localtime)
		 * @param $year,$month,$day if $date is not used
		 * @param $helpmsg a helpmessage for the statusline of the browser
		 * @param $options any other options to the inputfield
		 */
		function input($name, $date=0, $year=0, $month=0, $day=0, $helpmsg='', $options='')
		{
			if ( isset($GLOBALS['phpgw_info']['flags']['xslt_app'])
				&& $GLOBALS['phpgw_info']['flags']['xslt_app'])
			{
				self::_input_modern($name);
				return '';
			}
			else
			{
				return self::_input_legacy($name, $date, $year, $month, $day, $helpmsg, $options);
			}
		}

		/**
		 * @author ralfbecker
		 * converts the date-string back to an array with year, month, day and a timestamp
		*
		 * @param $datestr content of the inputfield generated by jscalendar::input()
		 * @param $raw key of the timestamp-field in the returned array or False of no timestamp
		 * @param $day,$month,$year keys for the array, eg. to set mday instead of day
		 */
		function input2date($datestr,$raw='raw',$day='day',$month='month',$year='year')
		{
			if ($datestr === '')
			{
				return False;
			}
			$fields = split('[./-]',$datestr);
			foreach(split('[./-]',$this->dateformat) as $n => $field)
			{
				$date[$field] = intval($fields[$n]);
				if($field == 'M')
				{
					for($i=1; $i <=12; $i++)
					{
						if(date('M',mktime(0,0,0,$i,1,2000)) == $fields[$n])
						{
							$date['m'] = $i;
						}
					}
				}
			}
			$ret = array(
				$year  => $date['Y'],
				$month => $date['m'],
				$day   => $date['d']
			);
			if ($raw)
			{
				$ret[$raw] = mktime(12,0,0,$date['m'],$date['d'],$date['Y']);
			}
			//echo "<p>jscalendar::input2date('$datestr','$raw',$day','$month','$year') = "; print_r($ret); echo "</p>\n";

			return $ret;
		}


		/**
		* Render the text box and trigger icon
		*
		* @deprecated
		* @access private
		*/
		public static function _input_legacy($name, $date, $year, $month, $day, $helpmsg, $options)
		{
			//echo "<p>jscalendar::input(name='$name', date='$date'='".date('Y-m-d',$date)."', year='$year', month='$month', day='$day')</p>\n";

			if ($date && (is_int($date) || is_numeric($date)))
			{
				$year  = intval($GLOBALS['phpgw']->common->show_date($date,'Y'));
				$month = intval($GLOBALS['phpgw']->common->show_date($date,'n'));
				$day   = intval($GLOBALS['phpgw']->common->show_date($date,'d'));
			}
			if ($year && $month && $day)
			{
				$date = date($this->dateformat,mktime(12,0,0,$month,$day,$year));
			}
			if ($helpmsg !== '')
			{
				$options .= " onFocus=\"self.status='".addslashes($helpmsg)."'; return true;\"" .
					" onBlur=\"self.status=''; return true;\"";
			}
			return
			'<input type="text" id="'.$name.'" name="'.$name.'" size="12" value="'.$date.'"'.$options.'/>
			<script type="text/javascript">
			<!--
			document.writeln(\'<img id="'.$name.'-trigger" src="'.$GLOBALS['phpgw']->common->find_image('phpgwapi','cal').'" alt="' . lang('date selector') . '" title="'.lang('Select date').'" style="cursor:pointer; cursor:hand;"/>\');
			Calendar.setup(
				{
					inputField  : "'.$name.'",
					button      : "'.$name.'-trigger"
				}
			);
			//-->
			</script>
			';
		}

		/**
		* Add an event listener to the trigger icon - used for XSLT
		*
		* @access private
		* @param string $name the element ID
		*/
		public static function _input_modern($id)
		{
			$GLOBALS['phpgw']->js->add_event('load', "Calendar.setup({inputField : '$id', button : '{$id}-trigger'});");
		}
	}
?>
