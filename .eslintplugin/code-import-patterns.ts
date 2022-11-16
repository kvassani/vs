import * as eslint from 'eslint';
import { TSESTree } from '@typescript-eslint/experimental-utils';
import * as path from 'path';
import minimatch from 'minimatch';
import { createImportRuleListener } from './utils';

const REPO_ROOT = path.normalize(path.join(__dirname, '../'));
