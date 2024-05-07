package com.ict.campyou.common;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class SshTunnelUtil {
   public static void setupSshTunnel() throws JSchException {

        JSch jsch = new JSch();
        // test.ppk 파일을 c드라이브에 가서 key라는 폴더 생성 후 
        // 안에 꼭 넣고 하이디로 연결 후 서버실행하기 !!!!!!!
        jsch.addIdentity("C:\\key\\test.ppk");

        Session session = jsch.getSession("ubuntu", "13.125.238.101", 22);
        session.setConfig("StrictHostKeyChecking", "no");
        session.connect();
        session.setPortForwardingL(3307, "127.0.0.1", 3306);
    }
}
