/*
 * Created on 22 Nov 2016 ( Time 07:54:14 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;
import java.util.List;
import java.util.Set;

/**
 * Persistent class for entity stored in table "tbl_roles"
 *
 *
 */

@Entity
@Table(name="tbl_roles")
// Define named queries here
public class TblRoles implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    private Integer    roleId       ;
    private String     roleName     ;
    private Integer isShown;
    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblRoles() {
		super();
    }
    
    public TblRoles(int roleId) {
		this.roleId=roleId;
    }
    
    public Integer getIsShown() {
		return isShown;
	}

	public void setIsShown(Integer isShown) {
		this.isShown = isShown;
	}

	//----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setRoleId( Integer roleId ) {
        this.roleId = roleId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="roleId", nullable=false)
    public Integer getRoleId() {
        return this.roleId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : roleName ( VARCHAR ) 
    public void setRoleName( String roleName ) {
        this.roleName = roleName;
    }
    @Column(name="roleName", nullable=false, length=100)
    public String getRoleName() {
        return this.roleName;
    }


    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------

    
    private Set<TblRoleLinkMapping> listOfTblRolelinkmapping;
    
    public void setListOfTblRolelinkmapping( Set<TblRoleLinkMapping> listOfTblRolelinkmapping ) {
        this.listOfTblRolelinkmapping = listOfTblRolelinkmapping;
    }
    @OneToMany(mappedBy="tblRoles", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    public Set<TblRoleLinkMapping> getListOfTblRolelinkmapping() {
        return this.listOfTblRolelinkmapping;
    }

    
    private Set<TblUserRoleMapping> listOfTblUserrolemapping;
    

    public void setListOfTblUserrolemapping( Set<TblUserRoleMapping> listOfTblUserrolemapping ) {
        this.listOfTblUserrolemapping = listOfTblUserrolemapping;
    }
    @OneToMany(mappedBy="tblRoles", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    public Set<TblUserRoleMapping> getListOfTblUserrolemapping() {
        return this.listOfTblUserrolemapping;
    }


    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(roleId);
        sb.append("]:"); 
        sb.append(roleName);
        return sb.toString(); 
    } 

}
