class ItemsModel {
  String? idItem;
  String? title;
  String? icon;
  String? page;

  ItemsModel({
    this.idItem,
    this.title,
    this.icon,
    this.page,
  });
}

final menuSuperAdmin = [
  ItemsModel(idItem: '1', title: 'Orden de Compras', icon: 'assets/svg/solCompras.svg', page: '1'),
  ItemsModel(idItem: '2', title: 'Contabilidad y Finanzas', icon: 'assets/svg/almacen.svg', page: '2'),
  ItemsModel(idItem: '3', title: 'Proveedores', icon: 'assets/svg/proveedores.svg', page: '3'),
  ItemsModel(idItem: '4', title: 'Almacén', icon: 'assets/svg/almacen.svg', page: '4'),
];

final menuGerencia = [
  ItemsModel(idItem: '1', title: 'Orden de Compras', icon: 'assets/svg/solCompras.svg', page: '1'),
  ItemsModel(idItem: '2', title: 'Contabilidad y Finanzas', icon: 'assets/svg/almacen.svg', page: '2'),
];

final menuOtros = [
  ItemsModel(idItem: '1', title: 'Orden de Compras', icon: 'assets/svg/solCompras.svg', page: '5'),
  ItemsModel(idItem: '3', title: 'Proveedores', icon: 'assets/svg/proveedores.svg', page: '3'),
  ItemsModel(idItem: '4', title: 'Almacén', icon: 'assets/svg/almacen.svg', page: '4'),
];
