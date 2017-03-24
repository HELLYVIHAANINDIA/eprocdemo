package com.eprocurement.common.utility;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

//import java.util.Random;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.eprocurement.common.services.ExceptionHandlerService;

public class EncryptDecryptUtils {

    private static final boolean ISSECURE = true;
    private static final String PASSWORD = "@Dev1238";
    private static final String SECRETKEY = "DES";
    private static final String UTF8 = "UTF-8";
    @Autowired
    private ExceptionHandlerService exceptionHandlerService;

    public String encrypt(final String data) {
        String encrypt = null;

        try {
            if (StringUtils.hasLength(data)) {
                DESKeySpec keySpec = new DESKeySpec(PASSWORD.getBytes(UTF8));
                SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(SECRETKEY);
                SecretKey key = keyFactory.generateSecret(keySpec);
                Cipher cipher = Cipher.getInstance(SECRETKEY); // cipher is not thread safe
                cipher.init(Cipher.ENCRYPT_MODE, key);
                sun.misc.BASE64Encoder base64encoder = new BASE64Encoder();
                String plainTextPassword = data;
                byte[] cleartext = plainTextPassword.getBytes(UTF8);
                encrypt = base64encoder.encode(cipher.doFinal(cleartext)).replace("/", "$$").replaceAll("\r\n", "");
            }
        } catch (IllegalBlockSizeException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (BadPaddingException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (NoSuchPaddingException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (InvalidKeySpecException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (NoSuchAlgorithmException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (UnsupportedEncodingException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (InvalidKeyException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (Exception ex) {
            exceptionHandlerService.logToFile(ex);
        }
        return encrypt;

    }

    public String decrypt(final String encrypt) {
        String decrypt = null;
        try {
            if (StringUtils.hasLength(encrypt)) {
                DESKeySpec keySpec = new DESKeySpec(PASSWORD.getBytes(UTF8));
                SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(SECRETKEY);
                SecretKey key = keyFactory.generateSecret(keySpec);
                sun.misc.BASE64Decoder base64decoder = new BASE64Decoder();
                Cipher cipher = Cipher.getInstance(SECRETKEY); // cipher is not thread safe
                String test = encrypt.replace("$$", "/").replace(" ", "+");
                byte[] encrypedPwdBytes = base64decoder.decodeBuffer(test);
                cipher = Cipher.getInstance(SECRETKEY);// cipher is not thread safe
                cipher.init(Cipher.DECRYPT_MODE, key);
                byte[] plainTextPwdBytes = (cipher.doFinal(encrypedPwdBytes));
                decrypt = new String(plainTextPwdBytes, UTF8);
            }
        } catch (IOException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (IllegalBlockSizeException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (BadPaddingException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (NoSuchPaddingException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (InvalidKeySpecException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (NoSuchAlgorithmException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (InvalidKeyException ex) {
            exceptionHandlerService.logToFile(ex);
        } catch (Exception ex) {
            exceptionHandlerService.logToFile(ex);
        }
        return decrypt;
    }
}
