# UART Communication System Design and Verification Using Verilog HDL

## 📌 Project Overview

This project implements a **UART (Universal Asynchronous Receiver Transmitter) Communication System** using **Verilog HDL**. The system consists of separate UART Transmitter and UART Receiver modules designed to perform serial data communication.

The functionality of both modules was verified using dedicated Verilog testbenches and simulation waveforms. An end-to-end **UART loopback test** was also performed to verify successful communication between the transmitter and receiver.

---

## 🚀 Features

* UART Transmitter (TX) implementation
* UART Receiver (RX) implementation
* Serial data transmission and reception
* Verilog HDL-based RTL design
* Separate testbenches for TX and RX modules
* End-to-end UART loopback verification
* Functional verification using simulation waveforms

---

## 🏗️ System Architecture

```text
Parallel Data
     │
     ▼
┌─────────────┐      Serial Data       ┌─────────────┐
│   UART TX   │ ────────────────────► │   UART RX   │
│ Transmitter │       TX / RX Line     │  Receiver   │
└─────────────┘                       └─────────────┘
     │                                      │
     ▼                                      ▼
Serial Output                         Parallel Output
```

The UART Transmitter converts parallel input data into serial data.

The UART Receiver receives the serial data and reconstructs the original parallel data.

---

## ⚙️ UART Frame Format

The UART communication follows a standard serial data format:

```text
Start Bit | Data Bits | Stop Bit
    0     |  8 Bits   |    1
```

Data is transmitted serially, typically starting with the least significant bit (LSB).

---

## 📂 Project Structure

```text
UART-Verilog-Design-and-Verification/
│
├── src/
│   ├── uart_tx.v
│   └── uart_rx.v
│
├── tb/
│   ├── uart_tx_tb.v
│   ├── uart_rx_tb.v
│ 
│
├── waveforms/
│   ├── uart_tx_waveform.png
│   ├── uart_rx_waveform.png
│   
│
├── README.md
└── LICENSE
```

---

## 🧩 Modules

### 1. UART Transmitter

The UART Transmitter module:

* Accepts parallel input data
* Generates a UART frame
* Adds a start bit
* Transmits the data serially
* Adds a stop bit after transmission

### 2. UART Receiver

The UART Receiver module:

* Detects the incoming start bit
* Receives serial data
* Reconstructs the original parallel data
* Detects the stop bit
* Provides the received parallel output

---

## 🧪 Verification

The design was verified using Verilog testbenches.

### UART TX Verification

The transmitter was tested by providing parallel input data and observing the generated serial output waveform.

### UART RX Verification

The receiver was tested by providing serial input data and verifying that the correct parallel data was reconstructed.

### UART Loopback Verification

The UART Transmitter output was connected to the UART Receiver input.

```text
UART TX ─────────────► UART RX
```

The transmitted data was successfully received and reconstructed, demonstrating correct end-to-end UART communication.

---

## 📊 Simulation Results

The following simulations were performed:

* UART Transmitter waveform verification
* UART Receiver waveform verification
* UART TX-RX loopback verification

Simulation waveforms are available in the `waveforms/` directory.

---

## 🛠️ Tools and Technologies

* **Verilog HDL**
* **RTL Design**
* **Verilog Testbenches**
* **Digital Logic Design**
* **Waveform-Based Functional Verification**

---

## 🎯 Learning Outcomes

Through this project, the following concepts were implemented and verified:

* UART serial communication
* RTL design using Verilog HDL
* Finite State Machine concepts
* Serial-to-parallel conversion
* Parallel-to-serial conversion
* Digital design simulation
* Testbench development
* Functional verification using waveforms

---

## 🔮 Future Improvements

Possible future enhancements include:

* Configurable baud rate
* Configurable data width
* Parity bit support
* Multiple stop-bit support
* FPGA implementation
* Hardware demonstration using an FPGA development board

---

## 👨‍💻 Author

**Shyam Krishna U**

Electronics and Communication Engineering

---

⭐ If you found this project useful, consider giving the repository a star!
