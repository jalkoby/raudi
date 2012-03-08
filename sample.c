#include <avr/interrupt.h>
ISR(PCINT2_vect)
{
}
void main
{
  PCMSK2 |= 1 << PCINT17 | 1 << PCINT18;
  PCICR |= 1 << PCIE2;
  DDRB |= 1 << 3;
  DDRC |= 1 << 3;
  PORTC |= 1 << 2;
  PORTD |= 1 << 6;
    int delay_time = 500;
  sei();
  while(1)
  {
      _delay_ms(delay_time);
      toggle_pin(PIN3);
  }
}
