enum OrderStatuses {
  newOrder('NEW'),
  caceled('CANCELED'),
  isBeingCollectedWait('ISBEINGCOLLECTED_WAIT'),
  isBeingCollected('ISBEINGCOLLECTED'),
  needRework('NEEDREWORK'),
  waitPay('WAITPAY'),
  payConfirmed('PAY_CONFIRMED'),
  paid('PAID'),
  onWay('ONWAY'),
  inPickup('INPICKUP'),
  reworked('REWORKED'),
  completed('COMPLETED');

  const OrderStatuses(this.cc);

  final String cc;
}
