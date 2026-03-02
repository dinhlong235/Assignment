/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Consumption")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Consumption.findAll", query = "SELECT c FROM Consumption c"),
    @NamedQuery(name = "Consumption.findByConsumptionId", query = "SELECT c FROM Consumption c WHERE c.consumptionId = :consumptionId"),
    @NamedQuery(name = "Consumption.findByTimestamp", query = "SELECT c FROM Consumption c WHERE c.timestamp = :timestamp"),
    @NamedQuery(name = "Consumption.findByEnergyKwh", query = "SELECT c FROM Consumption c WHERE c.energyKwh = :energyKwh"),
    @NamedQuery(name = "Consumption.findByTemperature", query = "SELECT c FROM Consumption c WHERE c.temperature = :temperature"),
    @NamedQuery(name = "Consumption.findByHumidity", query = "SELECT c FROM Consumption c WHERE c.humidity = :humidity")})
public class Consumption implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "consumption_id")
    private Integer consumptionId;
    @Column(name = "timestamp")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "energy_kwh")
    private BigDecimal energyKwh;
    @Column(name = "temperature")
    private BigDecimal temperature;
    @Column(name = "humidity")
    private BigDecimal humidity;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne
    private Users userId;

    public Consumption() {
    }

    public Consumption(Integer consumptionId) {
        this.consumptionId = consumptionId;
    }

    public Integer getConsumptionId() {
        return consumptionId;
    }

    public void setConsumptionId(Integer consumptionId) {
        this.consumptionId = consumptionId;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public BigDecimal getEnergyKwh() {
        return energyKwh;
    }

    public void setEnergyKwh(BigDecimal energyKwh) {
        this.energyKwh = energyKwh;
    }

    public BigDecimal getTemperature() {
        return temperature;
    }

    public void setTemperature(BigDecimal temperature) {
        this.temperature = temperature;
    }

    public BigDecimal getHumidity() {
        return humidity;
    }

    public void setHumidity(BigDecimal humidity) {
        this.humidity = humidity;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (consumptionId != null ? consumptionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Consumption)) {
            return false;
        }
        Consumption other = (Consumption) object;
        if ((this.consumptionId == null && other.consumptionId != null) || (this.consumptionId != null && !this.consumptionId.equals(other.consumptionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Consumption[ consumptionId=" + consumptionId + " ]";
    }
    
}
