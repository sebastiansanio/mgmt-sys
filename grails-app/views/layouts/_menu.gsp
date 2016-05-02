<sec:ifLoggedIn>
	<g:set var="menu" value="${
	[movement: ["op", "os", "in", "fi", "tr", "movementItem" ],
	account: ["account","accountTypeStatus"],
	concept: ["concept","conceptGroup","conceptAccount"],
	budget: ["budget","work","client"],
	balance: ["income","expenses","netting","balance","movementsExport"],
	supplier: ["supplier","supplierBudget","supplierExpenses","supplierBudgetTracing"],
	configuration: ["accountType","unitOfMeasurement","invoiceType","requestmap","secAuthority","secUser","report","import" ]
	]}" />
	
	<g:set var="menuGroupPriorities" value="${
	[movement: 1, account: 2, budget: 4, balance: 5, concept: 3, supplier: 6, configuration: 7	]}" />
	<g:set var="menuPriorities" value="${[op: 1,os: 2,in: 3,fi: 4,tr: 5,movementItem: 6,
	netting: 7 
	]}" />
	
	<g:set var="activeGroup" value="" />
	<nav class="navbar navbar-default" >
		<ul class="nav nav-tabs navbar-nav">
		
			<g:each var="menuItem" in="${menu.keySet().sort{menuGroupPriorities[it]}}">
				
				<g:set var="activeMark" value="" />
				<g:set var="itemsQuantity" value="${ 0}" />
				<g:each var="menuItemDetail" in="${menu[menuItem]}">
					<sec:access url="/${menuItemDetail}/index">
						<g:set var="itemsQuantity" value="${itemsQuantity + 1}" />
					</sec:access>
					
					<g:if test="${menuItemDetail == params.controller}">
						<g:set var="activeMark" value=" active" />	
						<g:set var="activeGroup" value="${menuItem}" />				
					</g:if>
				</g:each>
				<g:if test="${itemsQuantity > 0}" >
					<li class="${activeMark}">
						<a class="importantBig" href="#menuGroup${menuItem}" aria-controls="menuGroup${menuItem}" data-toggle="tab">
							<span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
							${message(code:'menuGroup.'+menuItem+'.label') }
						</a>
					</li>
						
				</g:if>
			</g:each>
			<li class="tab-content col-md-12">
				<g:each var="menuItem"	in="${menu.keySet().sort()}">
					<ul class=" tab-pane nav navbar-nav ${menuItem == activeGroup?'active':''}" id="menuGroup${menuItem}">
						<g:each status="i" var="c" in="${menu[menuItem].sort{menuPriorities[it]?:0}}">
							<sec:access url="/${c}/index">
								<li class="${params.controller == c ? "active" : ""}">
									<g:link	controller="${c}" action="index">
										<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
										<g:message code="menu.${c}.label" />
									</g:link>
								</li>
							</sec:access>
						</g:each>
					</ul>
				</g:each>
			</li>
		</ul>
	</nav>
</sec:ifLoggedIn>