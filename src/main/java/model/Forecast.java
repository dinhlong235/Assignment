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
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "Forecast")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Forecast.findAll", query = "SELECT f FROM Forecast f"),
    @NamedQuery(name = "Forecast.findByForecastId", query = "SELECT f FROM Forecast f WHERE f.forecastId = :forecastId"),
    @NamedQuery(name = "Forecast.findByForecastDate", query = "SELECT f FROM Forecast f WHERE f.forecastDate = :forecastDate"),
    @NamedQuery(name = "Forecast.findByPredictedKwh", query = "SELECT f FROM Forecast f WHERE f.predictedKwh = :predictedKwh"),
    @NamedQuery(name = "Forecast.findByModelUsed", query = "SELECT f FROM Forecast f WHERE f.modelUsed = :modelUsed"),
    @NamedQuery(name = "Forecast.findByAccuracy", query = "SELECT f FROM Forecast f WHERE f.accuracy = :accuracy")})
public class Forecast implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "forecast_id")
    private Integer forecastId;
    @Column(name = "forecast_date")
    @Temporal(TemporalType.DATE)
    private Date forecastDate;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "predicted_kwh")
    private BigDecimal predictedKwh;
    @Size(max = 50)
    @Column(name = "model_used")
    private String modelUsed;
    @Column(name = "accuracy")
    private BigDecimal accuracy;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @ManyToOne
    private Users userId;

    public Forecast() {
    }

    public Forecast(Integer forecastId) {
        this.forecastId = forecastId;
    }

    public Integer getForecastId() {
        return forecastId;
    }

    public void setForecastId(Integer forecastId) {
        this.forecastId = forecastId;
    }

    public Date getForecastDate() {
        return forecastDate;
    }

    public void setForecastDate(Date forecastDate) {
        this.forecastDate = forecastDate;
    }

    public BigDecimal getPredictedKwh() {
        return predictedKwh;
    }

    public void setPredictedKwh(BigDecimal predictedKwh) {
        this.predictedKwh = predictedKwh;
    }

    public String getModelUsed() {
        return modelUsed;
    }

    public void setModelUsed(String modelUsed) {
        this.modelUsed = modelUsed;
    }

    public BigDecimal getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(BigDecimal accuracy) {
        this.accuracy = accuracy;
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
        hash += (forecastId != null ? forecastId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Forecast)) {
            return false;
        }
        Forecast other = (Forecast) object;
        if ((this.forecastId == null && other.forecastId != null) || (this.forecastId != null && !this.forecastId.equals(other.forecastId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Forecast[ forecastId=" + forecastId + " ]";
    }
    
}
