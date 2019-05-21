#!/usr/bin/gemstone/smalltalk
"
	Create a Rowan project for an existing GitHub project that has not been rowanized
"
"
	For adapting an existing github project to Rowan, it is necessary to reference the project
		url and desirect commitish ... the project will be cloned as part of the creation 
		process
"
	| projectName project projectHome |
	projectHome := '$ROWAN_PROJECTS_HOME/RowanSample8/home'.
	projectName := 'Example11'.
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
			componentsPath: 'rowan/componenets'
			packagesPath: 'rowan/src'
			projectsPath: 'rowan/projects'
			projectUrl: 'https://github.com/dalehenrich/RowanExample
			committish: 'master' 
			comment: 'Example project exposing the standard project creation api'.
	project
		addComponentNamed: 'Core'
			definedGroupNames: 
				(Dictionary new
					add: 'core'  -> {};
					add: 'tests' -> { 'core' };
					yourself)
			gemstoneDefaultSymboldDictionaryForUser: 'SystemUser' -> 'ExampleCore'
			comment: 'Primary component used for loading entire system.';
		addPackageNamed: Example-Core'
			withConditions: { 'common' };
		addPackageNamed: 'Rowan-Tests'
			withConditions: { 'common' };
			andGroupName: 'tests';
		addPackageNamed: 'Example-GemStone-Extensions'
			toComponentNamed: 'Kernel'
			withConditions: { 'gemstone' }
			withGemStoneSymbolDictName: 'SystemUser' -> 'Globals';
		addPackageNamed: 'Rowan-Tests'
			toComponentNamed: 'Core'
			withConditions: { 'common' }
			andGroupName: 'tests';
		addPackageNamed: 'Rowan-GemStone-Test-Extensions'
			toComponentNamed: 'Core'
			withConditions: { 'gemstone' }
			andGroupName: 'tests'
			withGemStoneSymbolDictName: 'SystemUser' -> 'Globals';
		yourself.

	GsFile stdout 
		nextPutAll: projectHome asFileReference printString;
		lf

