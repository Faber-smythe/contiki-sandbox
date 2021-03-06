#include <stdio.h>
#include "contiki.h"
#include "helloworld.h"

#include "dev/serial-line.h"
#include "serial-shell.h"

PROCESS(helloworld_process, "Helloworld_process");
AUTOSTART_PROCESSES(&helloworld_process);

PROCESS_THREAD(helloworld_process, ev, data)
{
PROCESS_BEGIN();

helloworld();

serial_line_init();
serial_shell_init();

shell_reboot_init();
shell_power_init();
shell_ps_init();
shell_ping_init();

PROCESS_END();
}


