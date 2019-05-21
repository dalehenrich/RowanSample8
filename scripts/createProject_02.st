#!/usr/bin/gemstone/smalltalk
"
	Create a Rowan project from scratch, using all of the available defaults

	Other than the project name, the project artifacts should be identical to _01
"

	| projectName project projectHome |
	projectHome := '$ROWAN_PROJECTS_HOME/RowanSample8/home' asFileReference.
	projectName := 'Example02'.

	(projectHome / projectName) ensureDeleteAll.
	Rowan projectNamed: projectName ifPresent: [:project | project unload ].


	project := RwComponentProjectDefinition
		projectName: projectName 
			projectHome: projectHome
			useGit: true
			comment: 'Example project exposing the standard project creation api'.
	project
		addComponentNamed: 'Core'
			comment: 'Primary component used for loading entire system.';
		defaultSymbolDictionary: 'ExampleCore' 
			forUser: 'SystemUser';
		addPackageNamed: 'Example-Core1'
			withConditions: { 'common' };
		addPackageNamed: 'Example-Core2'
			withConditions: { 'common' };
		addPackageNamed: 'Example-Tests'
			withConditions: { 'common' }
			andGroupName: 'tests';
		addPackageNamed: 'Example-GemStone-Extensions'
			withConditions: { 'gemstone' }
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		addPackageNamed: 'Example-GemStone-Test-Extensions'
			withConditions: { 'gemstone' }
			andGroupName: 'tests'
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		yourself.

	(project componentNamed: 'Core')
		addDefinedGroupName: 'tests' includeGroups: { 'core' };
		yourself.
		
	project export.

	GsFile stdout 
		nextPutAll: projectHome asFileReference printString;
		lf

