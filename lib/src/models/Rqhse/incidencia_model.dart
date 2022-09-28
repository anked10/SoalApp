class IncidenciaModel {
  String? idIncidencia;
  String? correlativoIncidencia;
  String? idUsuario;
  String? personGenerated;
  String? personVericated;
  String? dateGenerated;
  String? dateVericated;
  String? cargoGenerado;
  String? businessName;
  String? statusName;
  //Detail from Incidencia
  String? dateCreated;
  String? typeIncidencia;
  String? locationIncidencia;
  String? hourIncidencia;
  String? placeEspecificIncidencia;
  String? descripcionObsIncidencia;
  String? accionRealizadaIncidencia;
  String? openClosedIncidencia;
  String? actoSeguroIncidencia;
  String? actitudFrustracion;
  String? actitudFatiga;
  String? actitudPrisa;
  String? appElementoInadeciado;
  String? appMalUso;
  String? appNoUso;
  String? herramientaInadecuado;
  String? herramientaMalUso;
  String? herramientaNoUso;
  String? proceNoseComprende;
  String? proceNoseSabe;
  String? proceNoseSigue;
  String? evaluacionCausaOtro;
  String? condicionSegura;
  String? herraInadecuada;
  String? herraDanada;
  String? herraFaltaMante;
  String? herraInexistente;
  String? ambienteExcesoRuido;
  String? ambienteFaltaOrden;
  String? ambientePeligroso;
  String? ambienteInaIluminacion;
  String? ambienteMalaSenalizacion;
  String? inseguraOtro;
  String? hseComentario;
  String? hseVerificacionFirma;
  String? hseVerificacionFecha;
  String? hseVerificacionHora;
  String? estadoAprobadoIncidencia;
  String? fechaEnviadoPendienteIncidencia;
  String? usuarioEnviadoPendienteIncidencia;
  String? statusIncidencia;

  IncidenciaModel({
    this.idIncidencia,
    this.correlativoIncidencia,
    this.idUsuario,
    this.personGenerated,
    this.personVericated,
    this.dateGenerated,
    this.dateVericated,
    this.cargoGenerado,
    this.businessName,
    this.statusName,
    //Detail from Incidencia
    this.dateCreated,
    this.typeIncidencia,
    this.locationIncidencia,
    this.hourIncidencia,
    this.placeEspecificIncidencia,
    this.descripcionObsIncidencia,
    this.accionRealizadaIncidencia,
    this.openClosedIncidencia,
    this.actoSeguroIncidencia,
    this.actitudFrustracion,
    this.actitudFatiga,
    this.actitudPrisa,
    this.appElementoInadeciado,
    this.appMalUso,
    this.appNoUso,
    this.herramientaInadecuado,
    this.herramientaMalUso,
    this.herramientaNoUso,
    this.proceNoseComprende,
    this.proceNoseSabe,
    this.proceNoseSigue,
    this.evaluacionCausaOtro,
    this.condicionSegura,
    this.herraInadecuada,
    this.herraDanada,
    this.herraFaltaMante,
    this.herraInexistente,
    this.ambienteExcesoRuido,
    this.ambienteFaltaOrden,
    this.ambientePeligroso,
    this.ambienteInaIluminacion,
    this.ambienteMalaSenalizacion,
    this.inseguraOtro,
    this.hseComentario,
    this.hseVerificacionFirma,
    this.hseVerificacionFecha,
    this.hseVerificacionHora,
    this.estadoAprobadoIncidencia,
    this.fechaEnviadoPendienteIncidencia,
    this.usuarioEnviadoPendienteIncidencia,
    this.statusIncidencia,
  });

  static List<IncidenciaModel> fromJsonList(List<dynamic> json) => json.map((i) => IncidenciaModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idIncidencia': idIncidencia,
        'correlativoIncidencia': correlativoIncidencia,
        'idUsuario': idUsuario,
        'personGenerated': personGenerated,
        'personVericated': personVericated,
        'dateGenerated': dateGenerated,
        'dateVericated': dateVericated,
        'cargoGenerado': cargoGenerado,
        'businessName': businessName,
        'statusName': statusName,
        //Detail from Incidencia
        'dateCreated': dateCreated,
        'typeIncidencia': typeIncidencia,
        'locationIncidencia': locationIncidencia,
        'hourIncidencia': hourIncidencia,
        'placeEspecificIncidencia': placeEspecificIncidencia,
        'descripcionObsIncidencia': descripcionObsIncidencia,
        'accionRealizadaIncidencia': accionRealizadaIncidencia,
        'openClosedIncidencia': openClosedIncidencia,
        'actoSeguroIncidencia': actoSeguroIncidencia,
        'actitudFrustracion': actitudFrustracion,
        'actitudFatiga': actitudFatiga,
        'actitudPrisa': actitudPrisa,
        'appElementoInadeciado': appElementoInadeciado,
        'appMalUso': appMalUso,
        'appNoUso': appNoUso,
        'herramientaInadecuado': herramientaInadecuado,
        'herramientaMalUso': herramientaMalUso,
        'herramientaNoUso': herramientaNoUso,
        'proceNoseComprende': proceNoseComprende,
        'proceNoseSabe': proceNoseSabe,
        'proceNoseSigue': proceNoseSigue,
        'evaluacionCausaOtro': evaluacionCausaOtro,
        'condicionSegura': condicionSegura,
        'herraInadecuada': herraInadecuada,
        'herraDanada': herraDanada,
        'herraFaltaMante': herraFaltaMante,
        'herraInexistente': herraInexistente,
        'ambienteExcesoRuido': ambienteExcesoRuido,
        'ambienteFaltaOrden': ambienteFaltaOrden,
        'ambientePeligroso': ambientePeligroso,
        'ambienteInaIluminacion': ambienteInaIluminacion,
        'ambienteMalaSenalizacion': ambienteMalaSenalizacion,
        'inseguraOtro': inseguraOtro,
        'hseComentario': hseComentario,
        'hseVerificacionFirma': hseVerificacionFirma,
        'hseVerificacionFecha': hseVerificacionFecha,
        'hseVerificacionHora': hseVerificacionHora,
        'estadoAprobadoIncidencia': estadoAprobadoIncidencia,
        'fechaEnviadoPendienteIncidencia': fechaEnviadoPendienteIncidencia,
        'usuarioEnviadoPendienteIncidencia': usuarioEnviadoPendienteIncidencia,
        'statusIncidencia': statusIncidencia,
      };

  factory IncidenciaModel.fromJson(Map<String, dynamic> json) => IncidenciaModel(
        idIncidencia: json["idIncidencia"],
        correlativoIncidencia: json["correlativoIncidencia"],
        idUsuario: json["idUsuario"],
        personGenerated: json["personGenerated"],
        personVericated: json["personVericated"],
        dateGenerated: json["dateGenerated"],
        dateVericated: json["dateVericated"],
        cargoGenerado: json["cargoGenerado"],
        businessName: json["businessName"],
        statusName: json["statusName"],
        //Detail from Incidencia
        dateCreated: json["dateCreated"],
        typeIncidencia: json["typeIncidencia"],
        locationIncidencia: json["locationIncidencia"],
        hourIncidencia: json["hourIncidencia"],
        placeEspecificIncidencia: json["placeEspecificIncidencia"],
        descripcionObsIncidencia: json["descripcionObsIncidencia"],
        accionRealizadaIncidencia: json["accionRealizadaIncidencia"],
        openClosedIncidencia: json["openClosedIncidencia"],
        actoSeguroIncidencia: json["actoSeguroIncidencia"],
        actitudFrustracion: json["actitudFrustracion"],
        actitudFatiga: json["actitudFatiga"],
        actitudPrisa: json["actitudPrisa"],
        appElementoInadeciado: json["appElementoInadeciado"],
        appMalUso: json["appMalUso"],
        appNoUso: json["appNoUso"],
        herramientaInadecuado: json["herramientaInadecuado"],
        herramientaMalUso: json["herramientaMalUso"],
        herramientaNoUso: json["herramientaNoUso"],
        proceNoseComprende: json["proceNoseComprende"],
        proceNoseSabe: json["proceNoseSabe"],
        proceNoseSigue: json["proceNoseSigue"],
        evaluacionCausaOtro: json["evaluacionCausaOtro"],
        condicionSegura: json["condicionSegura"],
        herraInadecuada: json["herraInadecuada"],
        herraDanada: json["herraDanada"],
        herraFaltaMante: json["herraFaltaMante"],
        herraInexistente: json["herraInexistente"],
        ambienteExcesoRuido: json["ambienteExcesoRuido"],
        ambienteFaltaOrden: json["ambienteFaltaOrden"],
        ambientePeligroso: json["ambientePeligroso"],
        ambienteInaIluminacion: json["ambienteInaIluminacion"],
        ambienteMalaSenalizacion: json["ambienteMalaSenalizacion"],
        inseguraOtro: json["inseguraOtro"],
        hseComentario: json["hseComentario"],
        hseVerificacionFirma: json["hseVerificacionFirma"],
        hseVerificacionFecha: json["hseVerificacionFecha"],
        hseVerificacionHora: json["hseVerificacionHora"],
        estadoAprobadoIncidencia: json["estadoAprobadoIncidencia"],
        fechaEnviadoPendienteIncidencia: json["fechaEnviadoPendienteIncidencia"],
        usuarioEnviadoPendienteIncidencia: json["usuarioEnviadoPendienteIncidencia"],
        statusIncidencia: json["statusIncidencia"],
      );

  factory IncidenciaModel.fromJson2(Map<String, dynamic> json) => IncidenciaModel(
        idIncidencia: json["id_incidencia"],
        correlativoIncidencia: json["incidencia_correlativo"],
        idUsuario: json["id_usuario"],
        personGenerated: json["generado_por"],
        personVericated: json["verificado_por"],
        dateGenerated: json["fecha_generada"],
        dateVericated: json["fecha_verificada"],
        cargoGenerado: json["cargo_generado"],
        businessName: json["empresa"],
        statusName: json["estado"],
        //Detail from Incidencia
        dateCreated: json["datos"]["fecha_creacion"],
        typeIncidencia: json["datos"]["incidencia_tipo"],
        locationIncidencia: json["datos"]["incidencia_locacion"],
        hourIncidencia: json["datos"]["incidencia_hora"],
        placeEspecificIncidencia: json["datos"]["incidencia_lugar_especifico"],
        descripcionObsIncidencia: json["datos"]["observacion_descripcion"],
        accionRealizadaIncidencia: json["datos"]["incidencia_accion_realizada"],
        openClosedIncidencia: json["datos"]["incidencia_open_close"],
        actoSeguroIncidencia: json["datos"]["acto_seguro"],
        actitudFrustracion: json["datos"]["actitud_frustracion"],
        actitudFatiga: json["datos"]["actitud_fatiga"],
        actitudPrisa: json["datos"]["actitud_prisa"],
        appElementoInadeciado: json["datos"]["epp_elemento_inadecuado"],
        appMalUso: json["datos"]["epp_mal_uso"],
        appNoUso: json["datos"]["epp_no_uso"],
        herramientaInadecuado: json["datos"]["herramienta_inadecuado"],
        herramientaMalUso: json["datos"]["herramienta_mal_uso"],
        herramientaNoUso: json["datos"]["herramienta_no_uso"],
        proceNoseComprende: json["datos"]["proce_nose_comprende"],
        proceNoseSabe: json["datos"]["proce_nose_sabe"],
        proceNoseSigue: json["datos"]["proce_nose_sigue"],
        evaluacionCausaOtro: json["datos"]["evaluacion_causa_otro"],
        condicionSegura: json["datos"]["condicion_segura"],
        herraInadecuada: json["datos"]["herra_inadecuada"],
        herraDanada: json["datos"]["herra_danada"],
        herraFaltaMante: json["datos"]["herra_falta_mante"],
        herraInexistente: json["datos"]["herra_inexistente"],
        ambienteExcesoRuido: json["datos"]["ambiente_exceso_ruido"],
        ambienteFaltaOrden: json["datos"]["ambiente_falta_orden"],
        ambientePeligroso: json["datos"]["ambiente_peligroso"],
        ambienteInaIluminacion: json["datos"]["ambiente_ina_iluminacion"],
        ambienteMalaSenalizacion: json["datos"]["ambiente_mala_senalizacion"],
        inseguraOtro: json["datos"]["inseguro_otro"],
        hseComentario: json["datos"]["hse_comentario"],
        hseVerificacionFirma: json["datos"]["hse_verificacion_firma"],
        hseVerificacionFecha: json["datos"]["hse_verificacion_fecha"],
        hseVerificacionHora: json["datos"]["hse_verificacion_hora"],
        estadoAprobadoIncidencia: json["datos"]["incidencia_estado_aprobado"],
        fechaEnviadoPendienteIncidencia: json["datos"]["fecha_enviado_pendiente"],
        usuarioEnviadoPendienteIncidencia: json["datos"]["usuario_enviado_pendiente"],
        statusIncidencia: json["datos"]["incidencia_estado"],
      );
}
