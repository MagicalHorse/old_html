class Ims::Des
  require 'openssl'  
  require 'base64'  
  ALG = 'DES-EDE3-CBC'  
  KEY = "intimeit"     #你的密钥
  DES_KEY = "intimeit"          #任意固定的值
  
  #加密  
  def encode(str)  
    des = OpenSSL::Cipher::Cipher.new(ALG)  
    des.pkcs5_keyivgen(KEY, DES_KEY)  
    des.encrypt  
    cipher = des.update(str)  
    cipher << des.final  
    return Base64.encode64(cipher) #Base64编码，才能保存到数据库  
  end  
  
  #解密    
  def decode(str)  
    str = Base64.decode64(str)  
    des = OpenSSL::Cipher::Cipher.new(ALG)  
    des.pkcs5_keyivgen(KEY, DES_KEY)  
    des.decrypt  
    des.update(str) + des.final  
  end  
end