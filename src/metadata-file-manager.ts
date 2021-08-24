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

interface IMetadataFileManager {
  execute(
    files: PullRequestFiles['all'],
    describeMetadataMap: Map<string, MetadataObject>
  ): void
}

class MetadataFileManager implements IMetadataFileManager {
  private files: PullRequestFiles['all']
  private describeMetadataMap: Map<string, MetadataObject>
  constructor(
    files: PullRequestFiles['all'],
    describeMetadataMap: Map<string, MetadataObject>
  ) {
    this.files = files
    this.describeMetadataMap = describeMetadataMap
  }

  execute(): Iterable<MetadataXMLDefinition> {
    const metadataXMLDefinitions: MetadataXMLDefinition[] = []
    metadataXMLDefinitions.push(
      ...this.getMetadataXMLDefinitions(this.files.added.files)
    )
    metadataXMLDefinitions.push(
      ...this.getMetadataXMLDefinitions(this.files.changed.files)
    )
    metadataXMLDefinitions.push(
      ...this.getMetadataXMLDefinitions(this.files.deleted.files)
    )
    metadataXMLDefinitions.push(
      ...this.getMetadataXMLDefinitions(this.files.modified.files)
    )
    return {
      [Symbol.iterator]: () => {
        return new MetadataXMLDefinitionIterator(metadataXMLDefinitions)
      }
    }
  }

  getMetadataXMLDefinitions(files: FileCommitted[]): MetadataXMLDefinition[] {
    const metadataXMLDefinitions: MetadataXMLDefinition[] = []
    for (const file of files) {
      for (const key of this.describeMetadataMap.keys()) {
        if (file.filename.includes(key)) {
          const describeMetadata = this.describeMetadataMap.get(key)
          if (describeMetadata) {
            const metadataXMLDefinition = this.createMetadataXMLInstance(
              describeMetadata,
              file
            )
            metadataXMLDefinitions.push(metadataXMLDefinition)
          }
          break
        }
      }
    }
    return metadataXMLDefinitions
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

class MetadataXMLDefinitionIterator implements Iterator<MetadataXMLDefinition> {
  private metadataXMLDefinitions: MetadataXMLDefinition[]
  private index = 0
  constructor(metadataXMLDefinitions: MetadataXMLDefinition[]) {
    this.metadataXMLDefinitions = metadataXMLDefinitions
  }
  private hasNext(): boolean {
    return this.index < this.metadataXMLDefinitions.length
  }

  next(): IteratorResult<MetadataXMLDefinition> {
    if (this.hasNext()) {
      this.index++
      return {
        done: !this.hasNext(),
        value: this.metadataXMLDefinitions[this.index - 1]
      }
    }
    return {done: true, value: undefined}
  }
}

export function execute(
  files: PullRequestFiles['all'],
  describeMetadataMap: Map<string, MetadataObject>
): Iterable<MetadataXMLDefinition> {
  return new MetadataFileManager(files, describeMetadataMap).execute()
}
