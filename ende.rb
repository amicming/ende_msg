require "base64"
require "openssl"

@endekey = '124jkhjsahdffhajhfjdsakhfjkh234h'

def encrypt(string)
 Base64.encode64(enstr(string)).gsub /\s/, ''
end

def decrypt(string)
 destr(Base64.decode64(string))
end

def cipher_val(endekeyval)
 cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
 if endekeyval == "en"
  cipher.encrypt
 else 
  cipher.decrypt
 end
 cipher.key = Digest::SHA256.digest(@endekey)
 return cipher	
end

def enstr(string)
 cipher = cipher_val("en")
 cipher.iv = initialization_vector = cipher.random_iv
 cipher_text = cipher.update(string)
 cipher_text << cipher.final
 return initialization_vector + cipher_text
end

def destr(encrypted)
 cipher = cipher_val("de")
 cipher.iv = encrypted.slice!(0,16)
 de = cipher.update(encrypted)
 de << cipher.final
end

$msg = "hi there"
$enc_string = encrypt($msg)
print $enc_string,"\n"
print decrypt($enc_string), "\n"
