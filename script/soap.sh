#Commands used with soapdenovo
#Download from http://sourceforge.net/projects/soapdenovo2/files/SOAPdenovo2/
#Download the bin version

#To perfom an assembly a config file is needed, the config file can be also found 
#in the Github folder

#To acces a few settings/options use 
chmod +x SOAPdenovo-127mer 
#or 
chmod +x SOAPdenovo-63mer 
#37mer should use less memory and is favorable
#Execute with
./SOAPdenovo-63mer

#To run SOAP use, this needs a config file to operate, creats a log file and
#an .err file
./SOAPdenovo-63mer all -s iets.config -K 63 -R -o graph_prefix1 > ass.log 2 > ass.err
