#!/usr/bin/gemstone/smalltalk
"
	Create a Rowan project from scratch
"

"
	defining a project entails defining 5 different sets of information:
		- a load specification ... used to load the project
		- one or more loadable components
		- one or more packages
		- zero or more project dependencies
		- disk layout of project specifying which directory the artifacts are to be stored on disk:
				- specification directory
				- component directory
				- package directory
				- project directory
"
	| projectName project projectHome |
	projectHome := '$ROWAN_PROJECTS_HOME/RowanSample8/home' asFileReference.
	projectName := 'Example01'.

	(projectHome / projectName) ensureDeleteAll.
	Rowan projectNamed: projectName ifPresent: [:project | project unload ].

	project := RwComponentProjectDefinition
		projectName: projectName 
			componentNamesToLoad: #( 'Core' )
			groupNamesToLoad: #( 'core' 'tests' )
			defaultComponentName: 'Core'
			defaultGroupName: 'core'
			packageFormat: 'tonel'
			projectHome: projectHome
			specsPath: 'rowan/specs'
			componentsPath: 'rowan/components'
			packagesPath: 'rowan/src'
			projectsPath: 'rowan/projects'
			useGit: true
			comment: 'Example project exposing the standard project creation api'.
	project
		addComponentNamed: 'Core'
			definedGroupNames: 
				(Dictionary new
					add: 'core'  -> {};
					add: 'tests' -> { 'core' };
					yourself)
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'ExampleCore'
			comment: 'Primary component used for loading entire system.';
		addPackageNamed: 'Example-Core1'
			withConditions: { 'common' };
		addPackageNamed: 'Example-Core2'
			withConditions: { 'common' };
		addPackageNamed: 'Example-Tests'
			withConditions: { 'common' }
			andGroupName: 'tests';
		addPackageNamed: 'Example-GemStone-Extensions'
			toComponentNamed: 'Core'
			withConditions: { 'gemstone' }
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		addPackageNamed: 'Example-GemStone-Test-Extensions'
			toComponentNamed: 'Core'
			withConditions: { 'gemstone' }
			andGroupName: 'tests'
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		yourself.

	project export.

	GsFile stdout 
		nextPutAll: projectHome asFileReference printString;
		lf

