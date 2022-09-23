CLASS z17_elephant DEFINITION INHERITING FROM Z17_MAMMAL
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS:
        Stamp EXCEPTIONS is_hungry low_strength,
        Swap_Tail IMPORTING person TYPE REF TO Z17_Person,
        Absorb_Water IMPORTING amount TYPE int8,
        Splash_Water IMPORTING person TYPE REF TO Z17_Person,
        constructor IMPORTING iv_name type string gender type c lv_color type string OPTIONAL lv_father type ref to z17_mammal OPTIONAL lv_mother type ref to z17_mammal OPTIONAL,
        set_force IMPORTING iv_force type INT8,
        give_birth REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA: force TYPE int8,
        trunk_capacity TYPE int8.
ENDCLASS.



CLASS z17_elephant IMPLEMENTATION.
  METHOD absorb_water.
    trunk_capacity += amount.
    IF trunk_capacity > 200.
        trunk_capacity = 200.
    ENDIF.
  ENDMETHOD.

  METHOD splash_water.
    IF trunk_capacity >= 75.
        trunk_capacity = 0.
        person->set_pissed( abap_true ).
        WRITE person->get_name(  ) && ' ist nun angepisst, weil er von ' && z17_animal~lv_name && ' angespritzt wurde!'.
    ELSE.
        WRITE person->get_name(  ) && ' wurde von ' && z17_animal~lv_name && ' angespritzt. ' && person->get_name(  ) && ' findet es eigentlich ganz cool'.
        trunk_capacity = 0.
    ENDIF.
  ENDMETHOD.

  METHOD stamp.
    IF force >= 50.
        z17_animal~lv_is_hungry = abap_true.
        force -= 50.
        WRITE z17_animal~lv_name && ' hat gestampft und ist nun wieder hungrig.'.
    ELSE.
        WRITE z17_animal~lv_name && ' wollte stampfen, war aber zu schwach.'.
    ENDIF.
  ENDMETHOD.

  METHOD swap_tail.
    IF force >= 30.
        force -= 30.
        person->set_pissed( abap_true ).
        WRITE z17_animal~lv_name && ' hat mit seinem Schwanz um ' && person->get_name(  ) && ' gewedelt. ' && person->get_name(  ) && ' ist nun angepisst.'.
    ELSE.
        WRITE z17_animal~lv_name && ' hat mit seinem Schwanz um ' && person->get_name(  ) && ' gewedelt. ' && person->get_name(  ) && ' findets cool.'.
    ENDIF.
  ENDMETHOD.

  METHOD give_birth.
    DATA child TYPE REF TO z17_elephant.
    IF mammal1->z17_animal~lv_gender EQ mammal2->z17_animal~lv_gender.
      RAISE same_gender.
    ENDIF.
    IF mammal1->z17_animal~lv_gender = 'f'.
      DATA(female) = mammal1.
      DATA(male) = mammal2.
    ELSE.
      female = mammal2.
      male = mammal1.
    ENDIF.
    IF female->z17_animal~lv_is_hungry EQ abap_true.
        RAISE hungry.
    ENDIF.
    DO cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = 4 )->get_next( ) TIMES.
      child = NEW #( iv_name = 'Justus Nummer ' &&  cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = 9999 )->get_next( ) gender = 'm' lv_color = 'grey' lv_father = male lv_mother = female ).
      female->childs = VALUE #( BASE female->childs ( child ) ).
      male->childs = VALUE #( BASE male->childs ( child ) ).
    ENDDO.
  ENDMETHOD.

  METHOD constructor.

    super->constructor( name = iv_name gender = gender color = lv_color iv_father = lv_father iv_mother = lv_mother ).
    me->trunk_capacity = 0.
    me->force = 0.

  ENDMETHOD.

  METHOD set_force.
    me->force = iv_force.
  ENDMETHOD.

ENDCLASS.
