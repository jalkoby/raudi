MAIN_action = <<AVR
  _delay_ms(delay_time);
  toggle_pin(PIN3);
AVR

SETUP_action = <<AVR
  int delay_time = 500;
AVR

INT0_action = <<AVR
  int k;
  for(k = 0; k < 4; k++);
AVR
