class ZCL_IOT_EVENT_RESOURCE definition
  public
  inheriting from CL_REST_RESOURCE
  final
  create public .

public section.

  methods IF_REST_RESOURCE~GET
    redefinition .
  methods IF_REST_RESOURCE~POST
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IOT_EVENT_RESOURCE IMPLEMENTATION.


  method IF_REST_RESOURCE~GET.
*CALL METHOD SUPER->IF_REST_RESOURCE~GET
*    .
    mo_response->set_status( cl_rest_status_code=>gc_success_ok ).
  endmethod.


  METHOD if_rest_resource~post.

    TYPES:
      BEGIN OF ty_attrib,
        origin   TYPE string,
        username TYPE string,
      END OF ty_attrib,

      BEGIN OF ty_message,
        publishtime  TYPE string,
        data         TYPE string,
        publish_time TYPE string,
        messageid    TYPE string,
        attributes   TYPE ty_attrib,
        message_id   TYPE string,
      END OF ty_message,

      BEGIN OF ty_data,
        subscription TYPE string,
        message      TYPE ty_message,
      END OF ty_data.

    DATA data TYPE ty_data.
    DATA(l_entity) = mo_request->get_entity( ).

    DATA(lv_json) = |{ l_entity->get_string_data( ) }|.

    /ui2/cl_json=>deserialize( EXPORTING json = lv_json pretty_name = /ui2/cl_json=>pretty_mode-none CHANGING data = data ).

    DATA lw TYPE ziot_event.
    data guid type GUID_16.

    CALL FUNCTION 'GUID_CREATE'
     IMPORTING
       EV_GUID_16       = guid.
    lw-uuid = guid.
    lw-subscription = data-subscription.
    lw-publishtime = data-message-publishtime.
    lw-data = data-message-data.
    lw-publish_time = data-message-publishtime.
    lw-messageid = data-message-messageid.
    lw-origin = data-message-attributes-origin.
    lw-username = data-message-attributes-username.
    lw-message_id = data-message-message_id.

    MODIFY ziot_event FROM lw.

*{"subscription":"projects\/nodeauthdemo-205312\/subscriptions\/sap",
*"message":{"publishTime":"2020-06-29T20:07:29.867Z","data":"eyJmb28iOiJiYXIifQ==","publish_time":"2020-06-29T20:07:29.867Z","messageId":"1270641935850217","attributes":{"origin":"nodejs-sample","username":"gcp"},"message_id":"1270641935850217"}}

    mo_response->set_status( cl_rest_status_code=>gc_success_ok ).

  ENDMETHOD.
ENDCLASS.
