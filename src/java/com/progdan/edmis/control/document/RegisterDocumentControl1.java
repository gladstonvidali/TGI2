package com.progdan.edmis.control.document;

import java.io.*;
import java.sql.*;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

import com.progdan.checksum.*;
import com.progdan.fileupload.*;
import com.progdan.logengine.*;
import com.progdan.zipengine.ZipCreate;
import com.progdan.edmis.model.user.User;
import com.progdan.edmis.model.document.Document;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class RegisterDocumentControl1 {
    private static Logger logger = Logger.getLogger(RegisterDocumentControl1.class.
            getName());
    private User user;
    public RegisterDocumentControl1(User user) {
        logger.debug(
                ">>> Start of RegisterDocumentControl.RegisterDocumentControl()***");
        this.user = user;
        logger.debug(
                "<<< End of RegisterDocumentControl.RegisterDocumentControl()***");
    }

    public boolean register(HttpSession session, HttpServletRequest request) {
        logger.debug(">>> Start of RegisterDocumentControl.register()***");
        DocumentReader read = new DocumentReader(user);
        boolean result = false;
        String temppath = null;
        String reppath = null;
        Properties props = new Properties();
        try {
            props.load(getClass().getResourceAsStream("/" + "db.properties"));
            temppath = props.getProperty("temppath", "/tmp");
            reppath = props.getProperty("reppath", "/EDMIS");
        } catch (IOException e) {
            logger.error(e);
        }
        DiskFileUpload fu = new DiskFileUpload();
        fu.setSizeMax( -1);
        fu.setRepositoryPath(temppath);
        try {
            List l = fu.parseRequest(request);
            Iterator i = l.iterator();
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (fi.getName() != null) {
                    File tmp = new File(temppath, basename(fi.getName()));
                    fi.write(tmp);
                    Checksum cs = new Checksum(new String[] {"-a", "sha512",
                                               temppath +
                                               System.getProperty(
                            "file.separator") +
                                               basename(fi.getName())});
                    String checksum = cs.getChecksum().substring(0, 128);
                    if (read.exists(checksum)) {
                        exists(session, tmp, checksum, read);
                        logger.debug(
                                "<<< End of RegisterDocumentControl.register()***");
                        return false;
                    } else {
                        exists(session, tmp, checksum, read);
                    }
                }
            }
        } catch (FileUploadException e) {
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
        logger.debug("<<< End of RegisterDocumentControl.register()***");
        return true;
    }

    private void exists(HttpSession session, File file, String checksum,
                        DocumentReader read) throws IOException {
        logger.debug(">>> Start of RegisterDocumentControl.exists()***");
        //logger.info("File " + file.getName() + " - sha512: " + checksum +
        //            " send by " + user.getLogin() +
        //            " already exists on the system!");
        logger.info("Arquivo alterado!!");
        
        String format = file.getName().substring(file.getName().lastIndexOf(".") +
                                                 1).toLowerCase();      
        file.renameTo(new File("/EDMIS", session.getAttribute("CodigoID") + "." + format));
        //Document doc = read.readDocument(checksum);
        //session.setAttribute("Document", doc);
        logger.debug("<<< End of RegisterDocumentControl.exists()***");
    }
    
    public void deleteDoc(HttpSession session) throws IOException {
        logger.debug(">>> Start of RegisterDocumentControl.deleteDoc()***");
        //logger.info("File " + file.getName() + " - sha512: " + checksum +
        //            " send by " + user.getLogin() +
        //            " already exists on the system!");
        logger.info("Arquivo alterado!!");
        
        String format = session.getAttribute("DocFormat").toString();
                
        File arquivo = new File("/EDMIS", session.getAttribute("CodigoID") + "." + format);
        arquivo.delete();
        Document doc = new Document();
        doc.setId(session.getAttribute("CodigoID").toString());
        DocumentWriter write = new DocumentWriter(user);
        write.deleteDocument(doc);
        
        //Document doc = read.readDocument(checksum);
        //session.setAttribute("Document", doc);
        logger.debug("<<< End of RegisterDocumentControl.deleteDoc()***");
    }

    private static String basename(String filename) {
        logger.debug(">>> Start of RegisterDocumentControl.basename()***");
        int slash = filename.lastIndexOf("\\");
        if (slash != -1) {
            filename = filename.substring(slash + 1);
            // I think Windows doesn't like /'s either
            slash = filename.lastIndexOf("/");
            if (slash != -1) {
                filename = filename.substring(slash + 1);
                // In case the name is C:foo.txt
            }
            slash = filename.lastIndexOf(":");
            if (slash != -1) {
                filename = filename.substring(slash + 1);
            }
        }
        logger.debug("<<< End of RegisterDocumentControl.basename()***");
        return filename;
    }

}
