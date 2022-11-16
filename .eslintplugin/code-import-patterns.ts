import * as eslint from 'eslint';
import { TSESTree } from '@typescript-eslint/experimental-utils';
import * as path from 'path';
import minimatch from 'minimatch';
import { createImportRuleListener } from './utils';

const REPO_ROOT = path.normalize(path.join(__dirname, '../'));

interface ConditionalPattern {
  when?: 'hasBrowser' | 'hasNode' | 'test';
	pattern: string;
}

interface RawImportPatternsConfig {
	target: string;
	layer?: 'common' | 'worker' | 'browser' | 'electron-sandbox' | 'node' | 'electron-browser' | 'electron-main';
	test?: boolean;
	restrictions: string | (string | ConditionalPattern)[];
}

interface LayerAllowRule {
	when: 'hasBrowser' | 'hasNode' | 'test';
	allow: string[];
}

type RawOption = RawImportPatternsConfig | LayerAllowRule;

function isLayerAllowRule(option: RawOption): option is LayerAllowRule {
	return !!((<LayerAllowRule>option).when && (<LayerAllowRule>option).allow);
}

interface ImportPatternsConfig {
	target: string;
	restrictions: string[];
}
