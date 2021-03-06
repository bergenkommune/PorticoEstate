<xsl:template match="data" xmlns:php="http://php.net/xsl">
	<div class="container new-application-page pt-5 my-container-top-fix" id="new-application-partialtwo">
		<a class="btn btn-light">
			<xsl:attribute name="href">
				<xsl:value-of select="application/frontpage_url"/>
			</xsl:attribute>
			<xsl:value-of select="php:function('lang', 'Go back')" />
		</a>
		<form action="" method="POST" id='application_form' name="form" class="needs-validation" novalidate="true">
			<div class="row mb-5">
				<div class="col-md-8 offset-md-2" data-bind="visible: !applicationSuccess()">
					<h1 class="font-weight-bold">
						<xsl:value-of select="php:function('lang', 'Contact and invoice information')" />
					</h1>
					<p>
						<xsl:value-of select="config/application_contact"/>
					</p>
					<hr class="mt-5 mb-5"></hr>
					<div class="mb-4">
						<xsl:call-template name="msgbox"/>
					</div>
					<h2 class="font-weight-bold mb-4">
						<xsl:value-of select="php:function('lang', 'applications')" />
					</h2>
					<p class="validationMessage" data-bind="visible: applicationCartItems().length == 0">
						<xsl:value-of select="php:function('lang', 'applicationcart empty')" />
					</p>
					<div data-bind="visible: applicationCartItems().length != 0">
						<div data-bind="foreach: applicationCartItems">
							<div class="applications p-4 mb-2">
								<div class="row">
									<span class="col-5" data-bind="text: building_name"></span>
									<div data-bind="" class="col-5">
										<span class="mr-3" data-bind="text: joinedResources"></span>
									</div>
									<div class="col-2 text-right">
										<span data-bind="click: $parent.deleteItem" class="far fa-trash-alt mr-2"></span>
									</div>
								</div>
								<div class="row" data-bind="foreach: dates">
									<span class="col-5" data-bind="text: date"></span>
									<span class="col-6" data-bind="text: periode"></span>
								</div>
							</div>
						</div>
						<hr class="mt-5 mb-5"></hr>
						<label>
							<xsl:value-of select="php:function('lang', 'invoice information')" />*</label>
						<input type="text" id="customer_identifier_type_hidden_field" hidden="hidden" value="{application/customer_identifier_type}"/>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="customer_identifier_type" id="privateRadio" data-bind="checked: typeApplicationRadio" value="ssn"/>
							<label class="form-check-label" for="privateRadio">
								<xsl:value-of select="php:function('lang', 'Private event')" />
							</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="customer_identifier_type" id="orgRadio" data-bind="checked: typeApplicationRadio" value="organization_number"/>
							<label class="form-check-label" for="orgRadio">
								<xsl:value-of select="php:function('lang', 'organization')" />
							</label>
						</div>
						<p data-bind="ifnot: typeApplicationSelected, visible: typeApplicationValidationMessage" class="isSelected validationMessage">
							<xsl:value-of select="php:function('lang', 'choose a')" />
						</p>
						<!-- Organization Number -->
						<div class="form-group" data-bind="visible: typeApplicationRadio() === 'organization_number'">
							<label>
								<xsl:value-of select="php:function('lang', 'organization number')" />*</label>
							<input name="customer_organization_number" value="{application/customer_organization_number}" type="text" class="form-control" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi gyldig organisasjonsnummer.
							</div>
						</div>
						<!-- Customer Personal Number -->
						<div class="form-group" data-bind="visible: typeApplicationRadio() === 'ssn'">
							<xsl:if test="string-length(application/customer_ssn)=0">
								<label>
									<xsl:value-of select="php:function('lang', 'Ssn')" />
									<xsl:text>*</xsl:text>
								</label>
							</xsl:if>
							<input class="form-control" name="customer_ssn" value="{application/customer_ssn}" required="true">
								<xsl:choose>
									<xsl:when test="application/customer_ssn != ''">
										<xsl:attribute name="type">
											<xsl:text>hidden</xsl:text>
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="type">
											<xsl:text>number</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="min">
											<xsl:text>11</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="max">
											<xsl:text>11</xsl:text>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
							<div class="invalid-feedback">
								Vennligst oppgi gyldig personnummer.
							</div>
						</div>
						<!-- Contact Name -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'contact_name')" />*</label>
							<input id="contactName" type="text" class="form-control" name="contact_name" value="{application/contact_name}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi navn.
							</div>
						</div>

						<!-- Street Name -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'responsible_street')" />*</label>
							<input type="text" class="form-control" name="responsible_street" value="{application/responsible_street}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi gatenavn.
							</div>
						</div>
						<!-- Zip Code -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'responsible_zip_code')" />*</label>
							<input type="text" class="form-control" name="responsible_zip_code" value="{application/responsible_zip_code}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi postnummer.
							</div>
						</div>
						<!-- City -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'responsible_city')" />*</label>
							<input type="text" class="form-control" name="responsible_city" value="{application/responsible_city}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi poststed.
							</div>
						</div>
						<!-- Email -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'contact_email')" />*</label>
							<input type="email" class="form-control" name="contact_email" value="{application/contact_email}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi gyldig e-post.
							</div>
						</div>
						<!-- Confirm Email -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'Confirm e-mail address')" />*</label>
							<input type="email" class="form-control" name="contact_email2" value="{application/contact_email2}" required="true"/>
							<div class="invalid-feedback">
								Vennligst bekreft e-posten din.
							</div>
						</div>
						<!-- Phone -->
						<div class="form-group">
							<label>
								<xsl:value-of select="php:function('lang', 'contact_phone')" />*</label>
							<input type="number" class="form-control" name="contact_phone" value="{application/contact_phone}" required="true"/>
							<div class="invalid-feedback">
								Vennligst oppgi gyldig telefonnummer.
							</div>
						</div>
						<hr class="mt-5"></hr>
						<button class="btn btn-light mb-5" type="submit">
							<xsl:value-of select="php:function('lang', 'send')" />
						</button>
					</div>
				</div>
			</div>
		</form>
		<!--<div class="mt-5"><pre data-bind="text: ko.toJSON(am, null, 2)"></pre></div> -->
		<div class="push"></div>
	</div>
	<script>
		var initialAcceptAllTerms = true;
		var initialSelection = [];
		var lang = <xsl:value-of select="php:function('js_lang', 'Do you want to delete application?')" />;
	</script>
</xsl:template>
