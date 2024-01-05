# AXI4-Lite
Advanced eXtensible Interface 4 (AXI4) is a family of buses defined as part of the fourth generation of the ARM Advanced Microcontroler Bus Architectrue (AMBA) standard.


## AXI4-Lite Interface Signals
The AXI4-Lite interface consists of five channels: Read Address, Read Data, Write Address, Write Data, and Write Response. An AXI4 read transaction using the Read Address and Data channels is shown in figure 1. Similarly an AXI4 write transaction using the Write Address, Data, and Response channels is shown in figure 2. Note that these figures depict burst transfers, which AXI4-Lite is incapable of.

![App Screenshot](https://www.realdigital.org/img/cede9613613d73fe3cf53fde7c215b73.png) 
#### Figure 1. AXI4 Read Transaction.  
![App Screenshot](https://www.realdigital.org/img/01b29efbcdc24d7feadbbb7c33cab5c5.png) 
#### Figure 1. AXI4 Write Transaction. 



## Handshake Process
All five transaction channels use the same VALID/READY handshake process to transfer address, data, and control information. This two-way flow control machanism means both the master and slave can control the rate at which the information moves between master and slave. The information source generates the VALID signal to indicate when the address, data or control information is available. The information destination generates the READY signal to indicate that it can accept the information. The handshake completes if both VALID and READY signals in a channel are asserted during a rising clock edge.

## Simulation
This repository also includes a simulation testbench of AXI4-lite to assist you in verifying the functionality of the AXI4-lite module. You can use this testbench with Verilog simulation tools like GTKWave to observe the module's operation.

### To run the simulation:

Ensure you have a Verilog simulation tool installed.

Compile the AXI4-lite and handshake files.

Run the simulation, and monitor the waveforms to observe the AXI4-lite and handshaking module's behavior.
### Run Locally

Clone the project

```bash
  git clone https://github.com/ZAIN-ALI-02/AXI4-lite
```

Go to the project directory

```bash
  cd AXI4-lite
```

Install dependencies

```bash
  install vscode
  install GTKWave
  install icarus verilog
```

## Contributing

Contributions are always welcome, suggestions, and issue reports. Feel free to create pull requests or open issues to help improve this AXI4-lite implementation. Together, we can make it even better!

## License
This project is open-source and available under the MIT License. You are free to use, modify, and distribute this code as long as you comply with the terms of the license.

## Documentation

[Documentation](http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf)

