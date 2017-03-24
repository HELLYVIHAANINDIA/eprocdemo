/*
 * Created on 22 Nov 2016 ( Time 07:57:03 )

 */
package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;


import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_rolelinkmapping"
 *
 *
 */

@Entity
@Table(name="tbl_rolelinkmapping")
public class TblRoleLinkMapping implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer    roleLinkmapId ;
    private TblLink tblLink     ;
    private TblRoles tblRoles    ;


   
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setRoleLinkmapId( Integer roleLinkmapId ) {
        this.roleLinkmapId = roleLinkmapId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="rolelinkmapId", nullable=false)
    public Integer getRoleLinkmapId() {
        return this.roleLinkmapId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
    public void setTblLink( TblLink tblLink ) {
        this.tblLink = tblLink;
    }
    @ManyToOne
    @JoinColumn(name="linkId", referencedColumnName="linkId")
    public TblLink getTblLink() {
        return this.tblLink;
    }

    
    public void setTblRoles( TblRoles tblRoles ) {
        this.tblRoles = tblRoles;
    }
    @ManyToOne
    @JoinColumn(name="roleId", referencedColumnName="roleId")
    public TblRoles getTblRoles() {
        return this.tblRoles;
    }


    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(roleLinkmapId);
        sb.append("]:"); 
        return sb.toString(); 
    } 

}
