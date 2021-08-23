import {AuraBundle, WebComponent } from './metadata/in-bundle-xml-definition'
import {CustomObject, Label, Profile, SharingRules} from './metadata/in-file-xml-definition'
import {Documents, Email} from './metadata/in-folder-xml-definition'
import {SimpleXMLDefinition} from './metadata/simple-xml-definition'
import {MetadataXMLDefinition} from './lib/metadataInterfaces'
import {PullRequestFiles} from './lib/gitDiffInterfaces'
import {MetadataObject, MetadataDescribe} from './lib/metadataDescribeInterfaces'
import * as core from '@actions/core'

export function execute(
  files: PullRequestFiles['all'],
  describeMetadataMap: Map<string, MetadataObject>
): void {
  for (const f of files.added.files) {
    core.info(f.filename)
    describeMetadataMap.get(f.filename)
  }
}