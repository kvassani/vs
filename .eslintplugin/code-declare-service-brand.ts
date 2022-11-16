import * as eslint from 'eslint';

export = new class DeclareServiceBrand implements eslint.Rule.RuleModule {
	
	readonly meta: eslint.Rule.RuleMetaData {
		fixable: 'code'
	};
	
	create(context: eslint.Rule.RuleContext): eslint.Rule.RuleListener {
		return {
			['PropertyDefinition[key.name="_serviceBrand"][value]']: (node: any) => {
				return context.report({
					node,
					message: `the '_serviceBrand'-property should not have a value...`,
					fix: (fixer) => {
						return fixer.replaceText(node, 'declare _serviceBrand: undefined;')
					}
				});
			}
		};
	}
};
