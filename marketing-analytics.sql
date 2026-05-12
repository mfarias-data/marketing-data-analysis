SQL
-- 1. Criação do Banco de Dados para o Portfólio
CREATE DATABASE MarketingAnalytics;
GO

USE MarketingAnalytics;
GO

-- 2. Tabela de Clientes (Baseada na estrutura da Olist)
CREATE TABLE Customers (
    customer_id UNIQUEIDENTIFIER PRIMARY KEY,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- 3. Tabela de Performance de Campanhas (Métricas de Marketing)
CREATE TABLE CampaignPerformance (
    campaign_id INT IDENTITY(1) PRIMARY KEY,
    campaign_name VARCHAR(100),
    channel VARCHAR(50), -- Email, Social Media, Paid Search
    budget_spent DECIMAL(10, 2),
    impressions INT,
    clicks INT,
    start_date DATE,
    end_date DATE
);

-- 4. Exemplo de Query de Análise: Calculando CTR e CPC
-- Esta query demonstra sua habilidade em transformar dados brutos em métricas de negócio.
GO
CREATE VIEW vw_MarketingInisghts AS
SELECT 
    campaign_name,
    channel,
    budget_spent,
    clicks,
    (CAST(clicks AS FLOAT) / NULLIF(impressions, 0)) * 100 AS CTR_Percentage,
    (budget_spent / NULLIF(clicks, 0)) AS Cost_Per_Click
FROM CampaignPerformance;
GO