import {
  AuraDefinitionBundle,
  LightningComponentBundle
} from './metadata/in-bundle-xml-definition'
import {
  CustomObject,
  CustomLabel,
  Profile,
  SharingRule
} from './metadata/in-file-xml-definition'
import {Document, EmailTemplate} from './metadata/in-folder-xml-definition'
import {SimpleXMLDefinition} from './metadata/simple-xml-definition'
import {MetadataXMLDefinition} from './lib/metadataInterfaces'
import {FileCommitted, PullRequestFiles} from './lib/gitDiffInterfaces'
import {MetadataObject} from './lib/metadataDescribeInterfaces'
import {MetadataConstants} from './Constants'
import * as path from 'path'

interface IMetadataFileManager {
  execute(
    files: PullRequestFiles['all'],
    describeMetadataMap: Map<string, MetadataObject>
  ): void
}

interface Metadata {
  [key: string]: MetadataXMLDefinition
}
class MetadataFileManager implements IMetadataFileManager {
  private files: PullRequestFiles['all']
  private describeMetadataMap: Map<string, MetadataObject>
  private metadataXMLDefinitions: Map<string, MetadataXMLDefinition>
  private metaFileMap: Map<string, FileCommitted>

  constructor(
    files: PullRequestFiles['all'],
    describeMetadataMap: Map<string, MetadataObject>
  ) {
    this.files = files
    this.describeMetadataMap = describeMetadataMap
    this.metadataXMLDefinitions = new Map<string, MetadataXMLDefinition>()
    this.metaFileMap = new Map<string, FileCommitted>()
  }

  execute(): Iterable<MetadataXMLDefinition> {
    this.getMetadataXMLDefinitions(this.files.added.files)

    this.getMetadataXMLDefinitions(this.files.changed.files)

    this.getMetadataXMLDefinitions(this.files.deleted.files)

    this.getMetadataXMLDefinitions(this.files.modified.files)

    return this.metadataXMLDefinitions.values()
  }

  getMetadataXMLDefinitions(files: FileCommitted[]): void {
    for (const file of files) {
      for (const key of this.describeMetadataMap.keys()) {
        if (file.filename.includes(key)) {
          const describeMetadata = this.describeMetadataMap.get(key)
          if (describeMetadata) {
            const metadataXMLDefinition = this.createMetadataXMLInstance(
              describeMetadata,
              file
            )
            if (file.filename.includes(MetadataConstants.META_SUFIX)) {
              const name = path
                .basename(file.filename)
                .replace(MetadataConstants.META_SUFIX, '')
              this.metaFileMap.set(name, file)
            } else {
              const name = path.basename(file.filename)
              this.metadataXMLDefinitions.set(name, metadataXMLDefinition)
            }
          }
          break
        }
      }
    }
  }

  createMetadataXMLInstance(
    describeMetadata: MetadataObject,
    file: FileCommitted
  ): MetadataXMLDefinition {
    switch (describeMetadata.xmlName) {
      case 'AuraDefinitionBundle':
        return new AuraDefinitionBundle(describeMetadata, file)
      case 'LightningComponentBundle':
        return new LightningComponentBundle(describeMetadata, file)
      case 'CustomObject':
        return new CustomObject(describeMetadata, file)
      case 'CustomLabels':
        return new CustomLabel(describeMetadata, file)
      case 'Profile':
        return new Profile(describeMetadata, file)
      case 'SharingRules':
        return new SharingRule(describeMetadata, file)
      case 'Documents':
        return new Document(describeMetadata, file)
      case 'EmailTemplate':
        return new EmailTemplate(describeMetadata, file)
      default:
        return new SimpleXMLDefinition(describeMetadata, file)
    }
  }
}

export function execute(
  files: PullRequestFiles['all'],
  describeMetadataMap: Map<string, MetadataObject>
): Iterable<MetadataXMLDefinition> {
  return new MetadataFileManager(files, describeMetadataMap).execute()
}
