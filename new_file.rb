def writeTLV(tag, data)
# $dataLen = mb_strlen($data);  
  dataLen = tag.length
# if ($dataLen > 127) {
  if dataLen > 127
# $binStr = decbin($dataLen);
    binStr = dataLen.to_s(2)   
# $binStrLen = strlen($binStr);
    binStrLen = binStr.length  
# $r = $binStrLen % 8
    r = binStrLen % 8
# $a = 8 - $r;
    a = 8 - r
# $binStr = str_pad($binStr, ($binStrLen+$a), "0", STR_PAD_LEFT);
    binStr = binStr.ljust(binStrLen+a, '0')
# $numOfBytes = strlen($binStr)/8;
    numOfBytes = binStr.length/8    
# $Length = chr($numOfBytes)^ chr(128);
#    len = numOfBytes.chr^128.chr
    t1 = numOfBytes.chr
    t2 = 128.chr
    len = 1^1
#    len=1
# for($i=0; $i < $numOfBytes; $i ++){
    i=0
    until i > numOfBytes  do
      len = len + binStr[i*8,8].to_i(2).chr
      i +=1;
    end  
  else
    len = dataLen.chr 
#      $Length = $Length . chr(bindec(substr($binStr, ($i*8) , 8)));
# substr($binStr, ($i*8) , 8) = binStr[i*8,8]
# bindec(substr($binStr, ($i*8) , 8)) = binStr[i*8,8].to_i(2)
# chr(bindec(substr($binStr, ($i*8) , 8))) = binStr[i*8,8].to_i(2).chr
#    }    
  end
  return tag+len+data
#  return tag+data
end


def mintchip_create(mintdata)
  version = mintdata[0]
  annotation = mintdata[1]
  payeeId = mintdata[2]
  currency = mintdata[3]
  value = mintdata[4]
  includecert = mintdata[5]
  responseurl = mintdata[6]
  challenge = mintdata[7] 
 
# Write payee-id
  payeeidTLV = writeTLV(0x04.chr, payeeId);
    
#    //Write currency
  currencyTLV = writeTLV(0x04.chr, currency);
    
#    //Write value
  valueTLV = writeTLV(0x04.chr, value);
    
#    //Write include-cert
  includecertTLV = writeTLV(0x01.chr, includecert);
    
#    //Write response-url
  responseurlTLV = writeTLV(0x16.chr, responseurl);
    
  reqData = payeeidTLV + currencyTLV + valueTLV + includecertTLV + responseurlTLV;
  
  if !challenge.nil?
    challengeTLV = writeTLV(0x16.chr, challenge)
    reqData = reqData + challengeTLV
  end  
    
#    //Write ValueMessageRequest
    valueMessageRequestTLV = writeTLV(0x30.chr, reqData);
    vmreqTLV = writeTLV(0xA1.chr, valueMessageRequestTLV);
    packetTLV = writeTLV(0xA2.chr, vmreqTLV);
    
    versionTLV = writeTLV(0x0A.chr, version)
    versionTLV = writeTLV(0xA0.chr, versionTLV)
    
    if !annotation.nil?
        annotationTLV = writeTLV(0x16.chr, annotation);
        annotationTLV = writeTLV(0xA1.chr, annotationTLV)
        messagePacketTLV = writeTLV(0x30.chr, versionTLV + annotationTLV + packetTLV);
      else
        messagePacketTLV = writeTLV(0x30.chr, versionTLV + packetTLV) 
    end
    
    mintchipreq = writeTLV(0x60.chr, messagePacketTLV);
    finalValueReg = Base64.encode64(mintchipreq) 
  
    puts "reqData" + finalValueReg
  
end    
  
  
  t1 = 0x01.chr
  t2 = 0xFF.chr
#  param = Array[ t1, "Created with PHP", pack("H*" , "1111222233334444"), t1, pack("H*" , 10), t2, "http://www.google.com", pack("H*" , "11223344")]
  param = Array[ t1, "Created with PHP", "1111222233334444", t1, "10", t2, "http://www.google.com", "11223344"]  
  
  mintchip_create(param)


