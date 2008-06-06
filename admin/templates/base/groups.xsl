<!-- $Id: groups.xsl 16932 2006-08-06 10:03:24Z skwashd $ -->

	<xsl:template name="groups">
		<xsl:choose>
			<xsl:when test="group_list">
				<xsl:apply-templates select="group_list"/>
			</xsl:when>
			<xsl:when test="group_edit">
				<xsl:apply-templates select="group_edit"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!-- BEGIN group_list -->

	<xsl:template match="group_list">
		<div id="admin_group_list">
			<xsl:if test="search_access = 1">
				<div class="search">
					<xsl:call-template name="search_field"/>
				</div>
			</xsl:if>

			<div>
				<xsl:call-template name="nextmatchs"/>
			</div>

			<table border="0" cellspacing="2" cellpadding="2">
				<thead>
					<xsl:apply-templates select="group_header"/>
				</thead>
				<tbody>
					<xsl:apply-templates select="group_data"/>
				</tbody>
			</table>
			<xsl:apply-templates select="group_add"/>
		</div>
	</xsl:template>

<!-- BEGIN group_header -->

	<xsl:template match="group_header">
		<tr>
			<th><a href="$sort_name"><xsl:value-of select="lang_name"/></a></th>
			<th><xsl:value-of select="lang_edit"/></th>
			<th><xsl:value-of select="lang_delete"/></th>
		</tr>
	</xsl:template>

<!-- BEGIN group_data -->
	<xsl:template match="group_data">
		<tr>
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
			<td><xsl:value-of select="group_name"/></td>
			<td  class="action">
				<xsl:variable name="edit_url" select="edit_url"/>
				<a href="{$edit_url}" class="th_text"><xsl:value-of select="lang_edit"/></a>
			</td>
			<td  class="action">
				<xsl:variable name="delete_url" select="delete_url"/>
				<a href="{$delete_url}" class="th_text"><xsl:value-of select="lang_delete"/></a>
			</td>
		</tr>
	</xsl:template>

<!-- BEGIN group_add -->
	<xsl:template match="group_add">
		<div>
			<xsl:if test="add_access = 1">
				<a href="{add_url}"><xsl:value-of select="lang_add" /></a>
			</xsl:if>
			<a href="{done_url}"><xsl:value-of select="lang_done" /></a>
		</div>
	</xsl:template>
<!-- END group_list -->

<!-- BEGIN group_edit -->
	<xsl:template match="group_edit">
		<div id="admin_group_edit">
			<h1><xsl:value-of select="page_title" /></h1>
			<xsl:if test="msgbox_data != ''">
				<xsl:call-template name="msgbox"/>
			</xsl:if>
			<form action="{edit_url}" method="post">
				<div class="yui-navset" id="group_edit_tabview">
					<xsl:value-of disable-output-escaping="yes" select="tabs" />

						<div class="yui-content">

							<div id="group">
								<h2><xsl:value-of select="lang_group" /></h2>
								<input type="hidden" name="values[account_id]" value="{account_id}"/>
								<ul id="admin_account_form">
									<li>
										<label for="account_name"><xsl:value-of select="lang_account_name" /></label>
										<input name="values[account_name]" value="{value_account_name}" id="account_name" /><br class="eol" />
									</li>
									<li>
										<label for="account_user"><xsl:value-of select="lang_include_user" /></label>
										<select name="account_user[]" id="account_user" multiple="multiple" size="5">
											<xsl:apply-templates select="guser_list"/>
										</select><br class="eol" />
									</li>
								</ul>
							</div>

							<div id="apps">
								<h2><xsl:value-of select="lang_permissions" /></h2>
								<ul class="app_list">
									<xsl:apply-templates select="app_list" />
								</ul>
							</div>
						</div>
					</div>
				<div class="button_group">
					<input type="submit" name="save" value="{lang_save}" />
					<input type="submit" name="cancel" value="{lang_cancel}" />
				</div>
			</form>
		</div>
	</xsl:template>

	<xsl:template match="guser_list">
		<option value="{account_id}">
			<xsl:if test="selected != 0">
				<xsl:attribute name="selected" value="selected" />
			</xsl:if>
			<xsl:value-of select="account_name" />
		</option>
	</xsl:template>

	<xsl:template match="app_list">
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
				<xsl:when test="acl_url != ''">
					<a href="{acl_url}"><img src="{acl_img}" title="{acl_img_name}" alt="{acl_img_name}" /></a>
				</xsl:when>
				<xsl:otherwise>
					<img src="{acl_img}" title="{acl_img_name}" alt="{acl_img_name}" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="grant_url != ''">
					<a href="{grant_url}"><img src="{grant_img}" title="{grant_img_name}" alt="{grant_img_name}" /></a>
				</xsl:when>
				<xsl:otherwise>
					<img src="{grant_img}" title="{grant_img_name}" alt="{grant_img_name}" />
				</xsl:otherwise>
			</xsl:choose>

			<input type="checkbox" id="{elmid}" name="{checkbox_name}" value="1">
				<xsl:if test="checked = '1'">
					<xsl:attribute name="checked">
						<xsl:text>checked</xsl:text>
					</xsl:attribute>
				</xsl:if>
			</input>
			<label for="{elmid}">
				<xsl:value-of select="app_title" />
			</label>
		</li>
	</xsl:template>
