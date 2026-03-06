package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "ServicePackages")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ServicePackages.findAll", query = "SELECT s FROM ServicePackages s"),
    @NamedQuery(name = "ServicePackages.findByPackageId", query = "SELECT s FROM ServicePackages s WHERE s.packageId = :packageId"),
    @NamedQuery(name = "ServicePackages.findByName", query = "SELECT s FROM ServicePackages s WHERE s.name = :name"),
    @NamedQuery(name = "ServicePackages.findByPrice", query = "SELECT s FROM ServicePackages s WHERE s.price = :price"),
    // MỚI THÊM: Query tìm theo loại gói (Household/Business)
    @NamedQuery(name = "ServicePackages.findByPackageType", query = "SELECT s FROM ServicePackages s WHERE s.packageType = :packageType"),
    @NamedQuery(name = "ServicePackages.findByDescription", query = "SELECT s FROM ServicePackages s WHERE s.description = :description")})
public class ServicePackages implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "package_id")
    private Integer packageId;

    @Size(max = 100)
    @Column(name = "name")
    private String name;

    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "price")
    private BigDecimal price;

    @Size(max = 2147483647)
    @Column(name = "description")
    private String description;

    // --- MỚI THÊM: Cột package_type ---
    @Size(max = 20)
    @Column(name = "package_type")
    private String packageType;
    // ----------------------------------

    @OneToMany(mappedBy = "packageId", fetch = FetchType.EAGER)
    private Collection<Orders> ordersCollection;

    @JoinColumn(name = "supplier_id", referencedColumnName = "supplier_id")
    @ManyToOne
    private Suppliers supplierId;

    public ServicePackages() {
    }

    public ServicePackages(Integer packageId) {
        this.packageId = packageId;
    }

    public Integer getPackageId() {
        return packageId;
    }

    public void setPackageId(Integer packageId) {
        this.packageId = packageId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // --- MỚI THÊM: Getter và Setter cho packageType ---
    public String getPackageType() {
        return packageType;
    }

    public void setPackageType(String packageType) {
        this.packageType = packageType;
    }
    // --------------------------------------------------

    @XmlTransient
    public Collection<Orders> getOrdersCollection() {
        return ordersCollection;
    }

    public void setOrdersCollection(Collection<Orders> ordersCollection) {
        this.ordersCollection = ordersCollection;
    }

    public Suppliers getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Suppliers supplierId) {
        this.supplierId = supplierId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (packageId != null ? packageId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ServicePackages)) {
            return false;
        }
        ServicePackages other = (ServicePackages) object;
        if ((this.packageId == null && other.packageId != null) || (this.packageId != null && !this.packageId.equals(other.packageId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.ServicePackages[ packageId=" + packageId + " ]";
    }

}
