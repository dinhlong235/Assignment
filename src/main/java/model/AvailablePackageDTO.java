package model;

import java.math.BigDecimal;

public class AvailablePackageDTO {
    private int packageId;
    private String supplierName;
    private String powerType; // EVN, solar, wind
    private String packageName;
    private BigDecimal price;
    private String description;

    public AvailablePackageDTO() {
    }

    public AvailablePackageDTO(int packageId, String supplierName, String powerType, String packageName, BigDecimal price, String description) {
        this.packageId = packageId;
        this.supplierName = supplierName;
        this.powerType = powerType;
        this.packageName = packageName;
        this.price = price;
        this.description = description;
    }

    // Getters
    public int getPackageId() { return packageId; }
    public String getSupplierName() { return supplierName; }
    public String getPowerType() { return powerType; }
    public String getPackageName() { return packageName; }
    public BigDecimal getPrice() { return price; }
    public String getDescription() { return description; }
}