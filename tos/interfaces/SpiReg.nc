/*
 * Copyright (c) 2017, 2019, 2021 Eric B. Decker
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * SpiReg: interface to a simple flavor of register based spi hardware.
 * For example the ST Micro LIS2DH12 Accelerometer is programmed using
 * a number of registers.
 *
 * @author Eric B. Decker <cire831@gmail.com>
 *
 * Different ST chips implement slightly different register protocols.
 * As of 2021 the most modern (ie. lsm6dsox) implement a 7 bit register
 * address and a R/_W bit.  Auto increment is a bit in a control register.
 *
 * The actual underlying driver and hardware implementation determines
 * how this all works.  The details won't effect this interface.
 */

interface SpiReg {
  /*
   * read               read one or more bytes from a single address.
   *                    issue the addr and then read len bytes.
   * readMultiple       read one or more bytes from a sequence of registers.
   *                    After each byte read will autoincrement the address
   *                    being referenced (ie. register address).  The chip
   *                    may have h/w assist for this function.
   *
   * input:	reg_addr starting register address
   *		*buf	 pointer to where to store incoming bytes
   *            len      how many bytes to read.
   */
  command void read(uint8_t reg_addr, uint8_t *buf, uint16_t len);
  command void readMultiple(uint8_t reg_addr, uint8_t *buf, uint16_t len);

  /*
   * readOne    read one byte from the specified address.
   *
   * input:	reg_addr starting register address
   * return:    byte
   */
  command uint8_t readOne(uint8_t reg_addr);

  /*
   * write              write one or more bytes from a single address.
   * writeMultiple      write one or more bytes from a sequence of registers.
   *
   * similar to write and writeMultiple
   *
   * input:	reg_addr starting register address
   *		*buf     pointer to where to stash incoming bytes
   *            len      how many bytes to write.
   */
  command void write(uint8_t reg_addr, uint8_t *buf, uint16_t len);
  command void writeMultiple(uint8_t reg_addr, uint8_t *buf, uint16_t len);

  /*
   * writeOne   write one byte to the specified address.
   *
   * input:	reg_addr starting register address
   *            data     data to write.
   */
  command void writeOne(uint8_t reg_addr, uint8_t data);
}
