CLASS z17_mammal DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: z17_animal.
    METHODS: Feed_Offspring IMPORTING food TYPE string,
      Try_Make_Child IMPORTING mammal1 TYPE REF TO z17_mammal mammal2 TYPE REF TO z17_mammal EXCEPTIONS same_gender no_luck,
      Give_Birth ABSTRACT IMPORTING mammal1 TYPE REF TO z17_mammal mammal2 TYPE REF TO z17_mammal EXCEPTIONS same_gender hungry,
      constructor IMPORTING name TYPE string gender TYPE c color TYPE string OPTIONAL iv_father TYPE REF TO z17_mammal OPTIONAL iv_mother TYPE REF TO z17_mammal.
  PROTECTED SECTION.
    DATA: Blood_Temperature TYPE int8,
          Mother            TYPE REF TO z17_mammal,
          Father            TYPE REF TO z17_mammal,
          Childs            TYPE STANDARD TABLE OF REF TO z17_mammal,
          Is_Pregnant       TYPE abap_bool.
  PRIVATE SECTION.
ENDCLASS.



CLASS z17_mammal IMPLEMENTATION.
  METHOD feed_offspring.
    LOOP AT Childs INTO DATA(child).
      IF child->z17_animal~lv_is_hungry EQ abap_true.
        child->z17_animal~eat( food ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD try_make_child.
    IF mammal1->z17_animal~lv_gender = 'm' AND mammal2->z17_animal~lv_gender = 'm'.
      RAISE same_gender.
    ENDIF.
    IF mammal1->z17_animal~lv_gender = 'f' AND mammal2->z17_animal~lv_gender = 'f'.
      RAISE same_gender.
    ENDIF.
    IF cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = 100 )->get_next( ) <= 60.
      IF mammal1->z17_animal~lv_gender = 'f'.
        mammal1->is_pregnant = abap_true.
      ELSE.
        mammal2->is_pregnant = abap_true.
      ENDIF.
    ELSE.
      RAISE no_luck.
    ENDIF.
  ENDMETHOD.

  METHOD z17_animal~eat.
    LOOP AT z17_animal~lt_food INTO DATA(s_food).
      IF s_food = iv_food.
        z17_animal~lv_is_hungry = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
    RAISE wrong_food.
  ENDMETHOD.

  METHOD z17_animal~move.
    IF z17_animal~lv_is_hungry EQ abap_true.
        RAISE hungry.
    ENDIF.
    z17_animal~lv_is_hungry = abap_true.
  ENDMETHOD.

  METHOD z17_animal~sleep.
    IF z17_animal~lv_is_hungry EQ abap_false.
        z17_animal~lv_is_hungry = abap_true.
    ELSE.
        RAISE hungry.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.

    Z17_animal~lv_is_hungry = abap_false.
    me->is_pregnant = abap_false.
    me->z17_animal~lv_is_hungry = abap_false.
    me->z17_animal~lv_name = name.
    me->z17_animal~lv_gender = gender.
    me->z17_animal~lv_color = color.
    me->mother = iv_mother.
    me->father = iv_father.
  ENDMETHOD.

ENDCLASS.
