/*
 * Created on 22 Nov 2016 ( Time 07:57:39 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;


import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_userrolemapping"
 *
 *
 */

@Entity
@Table(name="tbl_userrolemapping")
// Define named queries here
public class TblUserRoleMapping implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    private Integer    userRoleMapId ;
    private TblRoles tblRoles    ;
    private TblUserLogin tblUserlogin;


   
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setUserRoleMapId( Integer userRoleMapId ) {
        this.userRoleMapId = userRoleMapId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="userrolemapId", nullable=false)
    public Integer getUserRoleMapId() {
        return this.userRoleMapId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
    public void setTblRoles( TblRoles tblRoles ) {
        this.tblRoles = tblRoles;
    }
    @ManyToOne
    @JoinColumn(name="roleId", referencedColumnName="roleId")
    public TblRoles getTblRoles() {
        return this.tblRoles;
    }

    public void setTblUserlogin( TblUserLogin tblUserlogin ) {
        this.tblUserlogin = tblUserlogin;
    }
    @ManyToOne
    @JoinColumn(name="userId", referencedColumnName="userId")
    public TblUserLogin getTblUserlogin() {
        return this.tblUserlogin;
    }

    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(userRoleMapId);
        sb.append("]:"); 
        return sb.toString(); 
    } 

}
