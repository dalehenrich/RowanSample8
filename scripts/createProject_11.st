#!/usr/bin/gemstone/smalltalk
"
	Create a Rowan project for an existing GitHub project that has not been rowanized
"
"
	For adapting an existing github project to Rowan, it is necessary to reference the project
		url and desired commitish ... the project will be cloned as part of the creation 
		process
"
	| projectName project projectHome |
	projectHome := '$ROWAN_PROJECTS_HOME/RowanSample8/home' asFileReference.
	projectName := 'Example11'.

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
			projectUrl: 'https://github.com/dalehenrich/RowanExample'
			committish: 'master' 
			committishType: 'branch'
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
		addPackageNamed: 'Example-Core'
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

	project create.

	GsFile stdout 
		nextPutAll: projectHome asFileReference printString;
		lf

