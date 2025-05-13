resource "azurerm_resource_group" "rg" {
  name     = "infmon"
  location = "koreacentral"
}
# 인프모니터 서버 생성
resource "azurerm_linux_virtual_machine" "rg" {
  name = "infmon"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_D4s_v3"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.rg.id
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/azure_infmon_key.pub")
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# 가상 네트워크 
resource "azurerm_virtual_network" "rg" {
  name = "infmon"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space = ["10.0.0.0/16"]
}

# 서브넷 생성
resource "azurerm_subnet" "rg" {
  name = "infmon"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.rg.name
  address_prefixes = ["10.0.1.0/24"]
}

# 공개 IP 주소
resource "azurerm_public_ip" "rg" {
  name = "infmon"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
}



# 네트워크 인터페이스 생성
resource "azurerm_network_interface" "rg" {
  name = "infmon"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name = "infmon"
    subnet_id = azurerm_subnet.rg.id
    public_ip_address_id = azurerm_public_ip.rg.id
    private_ip_address_allocation = "Dynamic"
  }
}

# 네트워크 보안 그룹 생성
resource "azurerm_network_security_group" "rg" {
  name                = "infmon-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 네트워크 인터페이스와 NSG 연결
resource "azurerm_network_interface_security_group_association" "rg" {
  network_interface_id      = azurerm_network_interface.rg.id
  network_security_group_id = azurerm_network_security_group.rg.id
}
# NSG 규칙 생성
resource "azurerm_network_security_rule" "argocd" {
  name                        = "Allow-ArgoCD"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "30663"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.rg.name
}

resource "azurerm_network_security_rule" "grafana" {
  name                        = "Allow-Grafana"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "31176"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.rg.name
}

resource "azurerm_network_security_rule" "prometheus" {
  name                        = "Allow-Prometheus"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "30933"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.rg.name
}


# SSH 포트 열기
resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.rg.name
}