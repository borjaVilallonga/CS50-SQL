# Design Document

By BORJA VILALLONGA TEJELA

Video overview: <[URL HERE](https://youtu.be/ftcLPuHQsq0)> 

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?

The primary purpose of this db is to manage livestock traceability and genealogical records for a animal farm. It is designed to track the life cycle of each animal, including its birth, movements between different farms, observations and reproductive history. By maintaining strict parent-child relationships through internal IDs, the DB ensures a reliable family tree without relying on external references.

* Which people, places, things, etc. are you including in the scope of your database?

The DB includes the following entities:

    Animals: Individual animal identified by ear tags including sex and health status.
    Genealogy: Biological relationships between animals using internal DB identifiers.
    Places: Physical farm holdings or locations where the animals are kept.
    Events:
        Births: Specific details of calving events and their results.
        Movements: Log of transfers between different farm locations.
        Observations: Daily notes related with a specific animal.
    Timeframes: Defined calving seasons to categorize birth campaigns.
    Media: Photographic recors of animals for visual identification.

* Which people, places, things, etc. are *outside* the scope of your database?

The following are not included in this version:

    Financial Accounting: Tracking of specific sales prices. Just focus on byological data.
    External Animal: Is a close animal circuites internal pedigree.
    Feed and Ration Management: Detail of nutritional intake or water consumption is outside the current scope.
    Equipment and Maintenance: Management od farm machinery.

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?

    Register new livestock: User can insert animal records.
    Manage geological linage: User can link animal to their byological parents
    Track herd location: Users can record the entry and exit of animals across different farm holding.
    Monitor reproductive performance.

* What's beyond the scope of what a user should be able to do with your database?

    Register veterinary treatments.
    Upload image files directly into the database system.
    Generate reporting using  data from the database.
    Perform automatic genetic evaluationns.

## Representation

![E/R schema desing](<E:R schema.jpg>)

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?

    explotaciones: Physical farms where animals are located.
    paridera: Calving seasons used to group birhts into reproductive campaigns.
    animales: Individual livestock containing biological information.
    partos: Reproductive events associated with female animals.
    movimientos: Transfers of animal between different farms.
    imagenes: Photo records used for visual animal identificaction.
    observaciones: Notes to specific animal.

* What attributes will those entities have?

    explotaciones

        id_explotaciones
        nombre
        localization

    paridera

        id_paridera
        nombre
        fecha_inicio
        fecha_fin

    animales

        id_animal
        id_madre
        id_padre
        id_explotacion_nacimiento
        crotal
        crotal_reducido
        hierro
        raza
        sexo
        fecha_nacimiento
        fecha_baja
        estado

    partos

        id_parto
        id_animal
        id_paridera
        estado_parto
        fecha_parto
        tipo_parto
        observaciones

    movimientos

        id_movimientos
        id_animal
        id_explotacion
        fehca_entrada
        fecha_salida

    imagenes

        id_imagen
        id_animal
        ruta_archivo
        fecha_foto

    observaciones

        id_observacion
        id_animal
        fecha_registro
        observacion

* Why did you choose the types you did?

    INTEGER: is used for identifiers and FK because it provides efficient indexing anda relationships between tables.
    AUTOINCREMENT: gurarantes unique identifiers for each record.
    VARCHAR: is used for short textual fields or status values where the max expected size is limited
    TEXT: is used for flexible-length content.
    DATE: is used for birht dates, and temporal events to facilitate chronological queries and filtering.

* Why did you choose the constraints you did?

    PK: ensures every records is uniquely identifiable.
    FK: maintain consistency between related tables.
    UNIQUE: prevent field duplicate ear tag registrations.
    NOT NULL: guarantees that esential data such as identifiers are always providers.
    CHECK: constrains on fields restrict values to valid predefined options.
    ON DELETE CASCADE: removes dependets records such as images when an animal is deleted.
    ON DELETE SET NULL: mantain references preserves descendant animal records even if paretn records are deleted.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

    Farmas -> Animals (1:N)
        A farm can be a birth location of many animals, but each animal has only one birth farm.

    Animal -> Animals (1:N)
        An animal can be the parent of many animals, while each animal has at most one mother and one father. The relationships is implemented using id_mother and id_father FK.

    Animals -> Births (1:N)
        One animal can have multiple birth records throughout its life, but each birth record belongs to noly one animal.

    Calving Seasons -> Births (1:N)
        A calving season can contain many birth records, while each birth record belongs to one calving season.

    Animal -> Movements (1:N)
        Each animal can have ultiple movement records throughout its life, while each movements record refers to only one animal.

    Farms -> Movements (1:N)
        A farm can host movement records, but each movement record belongs to one farm.

    Animals -> Images (1:N)
        One animal can have multiple images associated with it for identification purpose, while each image belongs to a single animal.

    Animal -> Observations (1:N)
        One animal can have multiple observations, while each observation belongs to only one animal.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

-- INDEX

    idx_animals mother
        This index imporves the performance of queries involving family relationship and meternal linage.

    idx_movements_farm
        This index optimizes queries that retrieve animals currently located in a particular farm.

    idx_animals_ear_tag
        The ear tag is a unique identifier commonly used to located specific animals.

-- VIEW

    current_animal_by_farm
        Provides a list of animals currently located in each farm. This simplifies operational queries and reporting.

    animal_family_tree
        Creates a genealogy view showing mother and fatehr relationships for each animal. This view makes family data easier to retrieve.

    birth_statistics_by_season
        Aggregates birth records by calving season. This supports reporting and analysis tasks.

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?

    The system does not include veterinaty records such as vaccinations, diseases, treatments history.

    Images are stored only as a file paths rather than directly managing image data.

    Observations are implemented as a text entries. This provides flesibility but makes it difficult to classify, or analyze specific events automatically.

* What might your database not be able to represent very well?

It may not represent well:

    Detailed veterinary and health management information.
    Financial information.
    Genetic analysis and advanced breeding records.
    Complex animal lifecycle events beyond birhts and movements.
    Large-scale analytics involving environmental factors, productivity metrics or sensors data.

The desing priotitizes simplicity and readability over core functionality over highly specialized features.
