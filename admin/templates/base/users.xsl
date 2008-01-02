<!-- $Id: users.xsl 17913 2007-02-03 22:22:16Z sigurdne $ -->

	<xsl:template name="users">
		<xsl:choose>
			<xsl:when test="account_list">
				<xsl:apply-templates select="account_list"/>
			</xsl:when>
			<xsl:when test="account_edit">
				<xsl:apply-templates select="account_edit"/>
			</xsl:when>
			<xsl:when test="account_view">
				<xsl:apply-templates select="account_view"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!-- BEGIN user_list -->

	<xsl:template match="account_list">
		<center>
		<table border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td colspan="7" width="100%">
					<xsl:call-template name="nextmatchs"/>
				</td>
			</tr>
			<tr>
				<td colspan="7" width="100%" align="right">
					<xsl:choose>
						<xsl:when test="search_access = 'yes'">
							<xsl:call-template name="search_field"/>
						</xsl:when>
					</xsl:choose>
				</td>
			</tr>
				<xsl:apply-templates select="user_header"/>
				<xsl:apply-templates select="user_data"/>
				<xsl:apply-templates select="user_add"/>
		</table>
		</center>
	</xsl:template>

<!-- BEGIN user_header -->

	<xsl:template match="user_header">
		<xsl:variable name="sort_lid" select="sort_lid"/>
		<xsl:variable name="sort_firstname" select="sort_firstname"/>
		<xsl:variable name="sort_lastname" select="sort_lastname"/>
		<xsl:variable name="sort_status" select="sort_status"/>
		<xsl:variable name="lang_sort_statustext" select="lang_sort_statustext"/>
		<tr class="th">
			<td width="20%"><a href="{$sort_lid}" onMouseover="window.status='{$lang_sort_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_lid"/></a></td>
			<td width="20%"><a href="{$sort_firstname}" onMouseover="window.status='{$lang_sort_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_firstname"/></a></td>
			<td width="20%"><a href="{$sort_lastname}" onMouseover="window.status='{$lang_sort_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_lastname"/></a></td>
			<td width="6%" align="center"><a href="{$sort_status}" onMouseover="window.status='{$lang_sort_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_status"/></a></td>
			<td width="8%" align="center"><xsl:value-of select="lang_view"/></td>
			<td width="8%" align="center"><xsl:value-of select="lang_edit"/></td>
			<td width="8%" align="center"><xsl:value-of select="lang_delete"/></td>
		</tr>
	</xsl:template>

<!-- BEGIN user_data -->

	<xsl:template match="user_data">
		<xsl:variable name="lang_view_statustext"><xsl:value-of select="lang_view_statustext"/></xsl:variable>
		<xsl:variable name="lang_edit_statustext"><xsl:value-of select="lang_edit_statustext"/></xsl:variable>
		<xsl:variable name="lang_delete_statustext"><xsl:value-of select="lang_delete_statustext"/></xsl:variable>
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@class">
						<xsl:value-of select="@class"/>
					</xsl:when>
					<xsl:when test="position() mod 2 = 0">
						<xsl:text>row_off</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>row_on</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<td><xsl:value-of select="lid"/></td>
			<td><xsl:value-of select="firstname"/></td>
			<td><xsl:value-of select="lastname"/></td>
			<td align="center"><xsl:value-of select="status"/></td>
			<td align="center">
				<xsl:variable name="view_url" select="view_url"/>
				<a href="{$view_url}" onMouseover="window.status='{$lang_view_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_view"/></a>
			</td>
			<td align="center">
				<xsl:variable name="edit_url" select="edit_url"/>
				<a href="{$edit_url}" onMouseover="window.status='{$lang_edit_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_edit"/></a>
			</td>
			<td align="center">
				<xsl:variable name="delete_url" select="delete_url"/>
				<a href="{$delete_url}" onMouseover="window.status='{$lang_delete_statustext}';return true;" onMouseout="window.status='';return true;" class="th_text"><xsl:value-of select="lang_delete"/></a>
			</td>
		</tr>
	</xsl:template>

<!-- BEGIN user_add -->

	<xsl:template match="user_add">
		<tr height="50">
			<xsl:variable name="action_url"><xsl:value-of select="action_url"/></xsl:variable>
			<form method="post" action="{$action_url}">
			<td valign="bottom" colspan="3">
				<xsl:choose>
					<xsl:when test="add_access = 'yes'">
					<xsl:variable name="lang_add"><xsl:value-of select="lang_add"/></xsl:variable>
						<input type="submit" name="add" value="{$lang_add}" onMouseout="window.status='';return true;">
							<xsl:attribute name="onMouseover">
								<xsl:text>window.status='</xsl:text>
								<xsl:value-of select="lang_add_statustext"/>
								<xsl:text>'; return true;</xsl:text>
							</xsl:attribute>
						</input>
					</xsl:when>
				</xsl:choose>
			</td>
			<td align="right" valign="bottom" colspan="3">
			<xsl:variable name="lang_done"><xsl:value-of select="lang_done"/></xsl:variable>
				<input type="submit" name="done" value="{$lang_done}" onMouseout="window.status='';return true;">
					<xsl:attribute name="onMouseover">
						<xsl:text>window.status='</xsl:text>
							<xsl:value-of select="lang_done_statustext"/>
						<xsl:text>'; return true;</xsl:text>
					</xsl:attribute>
				</input>
			</td>
		</form>
		</tr>
	</xsl:template>

<!-- END user_list -->

<!-- BEGIN account_view -->

	<xsl:template match="account_view">
		<a href="{i_back}"><xsl:value-of select="l_back" /></a>
		<div id="admin_view_user">
			<h2><xsl:value-of select="l_user" /></h2>
			<span class="label"><xsl:value-of select="l_firstname" /></span>
			<span class="value"><xsl:value-of select="firstname"/></span><br class="eol" />

			<span class="label"><xsl:value-of select="l_lastname" /></span>
			<span class="value"><xsl:value-of select="lastname"/></span><br class="eol" />

			<span class="label"><xsl:value-of select="l_status" /></span>
			<span class="value"><xsl:value-of select="account_status"/></span><br class="eol" />
			
			<span class="label"><xsl:value-of select="l_expires" /></span>
			<span class="value"><xsl:value-of select="input_expires"/></span><br class="eol" />

			<span class="label"><xsl:value-of select="l_lastlogin" /></span>
			<span class="value"><xsl:value-of select="account_lastlogin"/></span><br class="eol" />
			
			<span class="label"><xsl:value-of select="l_lastloginfrom" /></span>
			<span class="value"><xsl:value-of select="lastloginfrom"/></span><br class="eol" />

			<span class="label"><xsl:value-of select="l_pwchange" /></span>
			<span class="value"><xsl:value-of select="account_lastpasswd_change"/></span><br class="eol" />

			<h2><xsl:value-of select="l_applications" /></h2>
			<div>
				<ul>
					<xsl:apply-templates select="permissions" />
				</ul>
			</div>
		</div>
		<div><a href="{i_back}"><xsl:value-of select="l_back" /></a></div>
	</xsl:template>

<!-- BEGIN account_edit -->

	<xsl:template match="account_edit">
		<table border="0" cellpadding="2" cellspacing="2" align="center" width="95%">
			<xsl:choose>
				<xsl:when test="msgbox_data != ''">
					<tr>
						<td align="center" colspan="2"><xsl:call-template name="msgbox"/></td>
					</tr>
				</xsl:when>
			</xsl:choose>
			<tr>
				<td valign="top">
<!-- {rows} -->
				</td>
				<td valign="top">
				<xsl:variable name="edit_url"><xsl:value-of select="edit_url"/></xsl:variable>
				<form method="POST" action="{$edit_url}">
					<table border="0" width="100%">
						<xsl:variable name="account_id" select="account_id"/>
						<xsl:variable name="account_lid" select="account_lid"/>
						<xsl:variable name="account_firstname" select="account_firstname"/>
						<xsl:variable name="account_lastname" select="account_lastname"/>
						<xsl:variable name="account_passwd" select="account_passwd"/>
						<xsl:variable name="account_passwd_2" select="account_passwd_2"/>
						<tr class="row_on">
							<td width="25%"><xsl:value-of select="lang_lid"/></td>
							<td width="25%"><input type="text" name="values[account_lid]" value="{$account_lid}"/></td>
							<td width="25%"><xsl:value-of select="lang_account_active"/></td>
							<td width="25%">
								<xsl:choose>
									<xsl:when test="account_status = 'yes'">
										<input type="checkbox" name="values[account_status]" value="A" checked="checked"/>
									</xsl:when>
									<xsl:otherwise>
										<input type="checkbox" name="values[account_status]" value="A"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr class="row_off">
							<td><xsl:value-of select="lang_firstname"/></td>
							<td><input type="text" name="values[account_firstname]" value="{$account_firstname}"/></td>
							<td><xsl:value-of select="lang_lastname"/></td>
							<td><input type="text" name="values[account_lastname]" value="{$account_lastname}"/></td>
						</tr>

<!-- BEGIN form_passwordinfo -->

						<tr class="row_on">
							<td><xsl:value-of select="lang_password"/></td>
							<td><input type="password" name="values[account_passwd]" value="{$account_passwd}"/></td>
							<td><xsl:value-of select="lang_reenter_password"/></td>
							<td><input type="password" name="values[account_passwd_2]" value="{$account_passwd_2}"/></td>
						</tr>

<!-- END form_passwordinfo -->

						<tr class="row_off">
							<td><xsl:value-of select="lang_contact"/></td>
							<td>
								<a href="{url_contacts}"><xsl:value-of select="url_contacts_text"/></a>
							</td>
							<td><xsl:value-of select="lang_changepassword"/></td>
							<td>
								<xsl:choose>
									<xsl:when test="changepassword = 1">
										<input type="checkbox" name="values[changepassword]" value="1" checked="checked"/>
									</xsl:when>
									<xsl:otherwise>
										<input type="checkbox" name="values[changepassword]" value="1"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

						<tr class="row_on">
							<td><xsl:value-of select="lang_groups"/></td>
							<td>
								<select name="account_groups[]" multiple="multiple">
									<xsl:apply-templates select="group_list"/>
								</select>
							</td>
							<td><xsl:value-of select="lang_anonymous"/></td>
							<td>
								<xsl:choose>
									<xsl:when test="changepassword = 0">
										<input type="checkbox" name="values[anonymous]" value="1" checked="checked"/>
									</xsl:when>
									<xsl:otherwise>
										<input type="checkbox" name="values[anonymous]" value="1"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

						<tr class="row_off">
							<td><xsl:value-of select="lang_expires"/></td>
							<td><xsl:value-of disable-output-escaping="yes" select="select_expires"/></td>
							<td><xsl:value-of select="lang_never"/></td>
							<td>
								<xsl:choose>
									<xsl:when test="expires_never = 'yes'">
										<input type="checkbox" name="values[expires_never]" value="True" checked="checked"/>
									</xsl:when>
									<xsl:otherwise>
										<input type="checkbox" name="values[expires_never]" value="True"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr class="row_off">
							<td><label for="values_quota"><xsl:value-of select="lang_quota"/></label></td>
							<td><input type="text" name="values[quota]" id="values_quota" value="{account_quota}" />Mb</td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
						<tr>
							<td colspan="4">
								<h2><xsl:value-of select="lang_applications" /></h2>
								<ul>
									<xsl:apply-templates select="app_list" />
								</ul>
							</td>
						</tr>
					</table>
					<div class="button_group">
						<xsl:variable name="lang_save"><xsl:value-of select="lang_save"/></xsl:variable>
						<input type="submit" name="values[save]" value="{$lang_save}"/>
						<xsl:variable name="lang_cancel"><xsl:value-of select="lang_cancel"/></xsl:variable>
						<input type="submit" name="values[cancel]" value="{$lang_cancel}"/>
					</div>
				</form>
				</td>
			</tr>
		</table>
	</xsl:template>

<!-- BEGIN group_list -->

	<xsl:template match="group_list">
		<xsl:variable name="account_id" select="account_id"/>
		<xsl:choose>
			<xsl:when test="selected != ''">
				<option value="{$account_id}" selected="selected"><xsl:value-of select="account_lid"/></option>
			</xsl:when>
			<xsl:otherwise>
				<option value="{$account_id}"><xsl:value-of select="account_lid"/></option>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- BEGIN app_list -->

	<xsl:template match="app_list">
		<xsl:variable name="checkbox_name" select="checkbox_name" />
		<li>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">
						<xsl:text>row_off</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>row_on</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="checked = '1'">
					<input type="checkbox" id="{$checkbox_name}" name="{$checkbox_name}" value="1" checked="checked" />
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" id="{$checkbox_name}" name="{$checkbox_name}" value="1" />
				</xsl:otherwise>
			</xsl:choose>
			<label for="{$checkbox_name}">
				<xsl:value-of select="app_title" />
			</label>
		</li>
	</xsl:template>

	<xsl:template match="permissions">
		<li>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@class">
						<xsl:value-of select="@class"/>
					</xsl:when>
					<xsl:when test="position() mod 2 = 0">
						<xsl:text>row_off</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>row_on</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<span>
				<xsl:choose>
					<xsl:when test="enabled = 1">
						X
					</xsl:when>
					<xsl:otherwise>
						&nbsp;
					</xsl:otherwise>
				</xsl:choose>
			</span>
			<xsl:value-of select="name"/>
		</li>
	</xsl:template>
	
