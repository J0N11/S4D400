*&---------------------------------------------------------------------*
*& Report z17_zoo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_zoo.
CLASS mammal DEFINITION ABSTRACT.
PUBLIC SECTION.
INTERFACES: z17_animal.
METHODS: Feed_Offspring IMPORTING food TYPE string,
         Try_Make_Child IMPORTING mammal1 TYPE REF TO mammal mammal2 TYPE REF TO mammal,
         Give_Birth IMPORTING mammal1 TYPE REF TO mammal mammal2 TYPE REF TO mammal.
PROTECTED SECTION.
DATA: Blood_Temperature TYPE INT8,
      Mother TYPE REF TO mammal,
      Father TYPE REF TO mammal,
      Childs TYPE STANDARD TABLE OF REF TO mammal,
      Is_Pregnant TYPE boolean.

ENDCLASS.

CLASS mammal IMPLEMENTATION.

  METHOD feed_offspring.

  ENDMETHOD.

  METHOD give_birth.

  ENDMETHOD.

  METHOD try_make_child.

  ENDMETHOD.

ENDCLASS.
