class Alocacao {
  dynamic id;
  dynamic user_id;
  dynamic motorista;
  dynamic motoristaRuc;
  dynamic placa;
  dynamic tipo;
  dynamic veiculoNacao;
  dynamic tempo;
  dynamic dataHora;
  dynamic dataHoraExpiracao;
  dynamic rua;
  dynamic vaga;
  dynamic moeda;
  dynamic trocoGS;
  dynamic pago;
  dynamic user_id_pago;
  dynamic valorPago;
  dynamic valorPagoMoeda;
  dynamic statusTempo;
  dynamic data;
  dynamic urlValidacao;
  dynamic idNoHash;
  dynamic faturaValidade;
  dynamic status;
  dynamic debitos;
  dynamic totalAlocacoes;
  dynamic valorRecebidoMoeda;
  dynamic iva;
  dynamic grav;
  dynamic notaFiscal;
  dynamic timbrado_numero;
  dynamic timbrado_vigencia_inicio;
  dynamic timbrado_vigencia_fim;
  dynamic mensagem;

  //erro msg
  dynamic statusErrorMsg;

  Alocacao({this.id, this.user_id, this.motorista, this.motoristaRuc, this.placa, this.tipo, this.veiculoNacao, this.tempo, this.dataHora, this.dataHoraExpiracao, this.rua, this.vaga, this.moeda, this.pago, this.user_id_pago, this.valorPago, this.statusTempo, this.data, this.urlValidacao, this.idNoHash, this.faturaValidade, this.trocoGS, this.valorPagoMoeda, this.status, this.debitos, this.totalAlocacoes, this.valorRecebidoMoeda, this.iva, this.grav, this.notaFiscal, this.timbrado_numero, this.timbrado_vigencia_inicio, this.timbrado_vigencia_fim, this.statusErrorMsg, this.mensagem});

  factory Alocacao.fromJson(Map<String, dynamic> json) {
    return Alocacao(
        id: json["id"],
        user_id: json["user_id"],
        motorista: json["motorista"],
        motoristaRuc: json["motoristaRuc"],
        placa: json["placa"],
        tipo: json["tipo"],
        veiculoNacao: json["veiculoNacao"],
        tempo: json["tempo"],
        dataHora: json["dataHora"],
        dataHoraExpiracao: json["dataHoraExpiracao"],
        rua: json["rua"],
        vaga: json["vaga"],
        moeda: json["moeda"],
        pago: json["pago"],
        user_id_pago: json["user_id_pago"],
        valorPago: json["valorPago"],
        statusTempo: json["statusTempo"],
        data: json["data"],
        urlValidacao: json["urlValidacao"],
        idNoHash: json["idNoHash"],
        faturaValidade: json["faturaValidade"],
        trocoGS: json["trocoGS"],
        valorPagoMoeda: json["valorPagoMoeda"],
        status: json["status"],
        valorRecebidoMoeda: json["valorRecebidoMoeda"],
        iva: json["iva"],
        grav: json["grav"],
        debitos: json["debitos"],
        totalAlocacoes: json["totalAlocacoes"],
        notaFiscal: json["notaFiscal"],
        timbrado_numero: json["timbrado_numero"],
        timbrado_vigencia_inicio: json["timbrado_vigencia_inicio"],
        timbrado_vigencia_fim: json["timbrado_vigencia_fim"],
        statusErrorMsg: json["statusErrorMsg"],
        mensagem: json["mensagem"]);
  }
}
