<%@ page import="mgmt.concept.Concept" %>



			<div class="${hasErrors(bean: conceptInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="concept.code.label" default="Code" /></label>
				<div>
					<g:textField class="form-control" name="code" value="${conceptInstance?.code}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'conceptAccount', 'has-error')} required">
				<label for="conceptAccount" class="control-label"><g:message code="concept.conceptAccount.label" default="Concept Account" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="conceptAccount" name="conceptAccount.id" from="${mgmt.concept.ConceptAccount.list()}" optionKey="id" required="" value="${conceptInstance?.conceptAccount?.id}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'conceptGroup', 'has-error')} required">
				<label for="conceptGroup" class="control-label"><g:message code="concept.conceptGroup.label" default="Concept Group" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="conceptGroup" name="conceptGroup.id" from="${mgmt.concept.ConceptGroup.list()}" optionKey="id" required="" value="${conceptInstance?.conceptGroup?.id}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'description', 'has-error')} ">
				<label for="description" class="control-label"><g:message code="concept.description.label" default="Description" /></label>
				<div>
					<g:textField class="form-control" name="description" value="${conceptInstance?.description}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInFiWork', 'has-error')} ">
				<label for="validInFiWork" class="control-label"><g:message code="concept.validInFiWork.label" default="Valid In Fi Work" /></label>
				<div>
					<g:checkBox name="validInFiWork" value="${conceptInstance?.validInFiWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInInNoWork', 'has-error')} ">
				<label for="validInInNoWork" class="control-label"><g:message code="concept.validInInNoWork.label" default="Valid In In No Work" /></label>
				<div>
					<g:checkBox name="validInInNoWork" value="${conceptInstance?.validInInNoWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInInWork', 'has-error')} ">
				<label for="validInInWork" class="control-label"><g:message code="concept.validInInWork.label" default="Valid In In Work" /></label>
				<div>
					<g:checkBox name="validInInWork" value="${conceptInstance?.validInInWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInOpNoWork', 'has-error')} ">
				<label for="validInOpNoWork" class="control-label"><g:message code="concept.validInOpNoWork.label" default="Valid In Op No Work" /></label>
				<div>
					<g:checkBox name="validInOpNoWork" value="${conceptInstance?.validInOpNoWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInOpWork', 'has-error')} ">
				<label for="validInOpWork" class="control-label"><g:message code="concept.validInOpWork.label" default="Valid In Op Work" /></label>
				<div>
					<g:checkBox name="validInOpWork" value="${conceptInstance?.validInOpWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInOsNoWork', 'has-error')} ">
				<label for="validInOsNoWork" class="control-label"><g:message code="concept.validInOsNoWork.label" default="Valid In Os No Work" /></label>
				<div>
					<g:checkBox name="validInOsNoWork" value="${conceptInstance?.validInOsNoWork}" />
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'validInOsWork', 'has-error')} ">
				<label for="validInOsWork" class="control-label"><g:message code="concept.validInOsWork.label" default="Valid In Os Work" /></label>
				<div>
					<g:checkBox name="validInOsWork" value="${conceptInstance?.validInOsWork}" />
				</div>
			</div>
