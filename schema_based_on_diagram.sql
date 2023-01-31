CREATE TABLE "patients"(
    "id" INTEGER NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL
);
ALTER TABLE
    "patients" ADD PRIMARY KEY("id");
CREATE TABLE "invoices"(
    "id" INTEGER NULL,
    "total_amount" DECIMAL(8, 2) NOT NULL,
    "generated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "payed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "medical_history__id" INTEGER NOT NULL
);
ALTER TABLE
    "invoices" ADD PRIMARY KEY("id");
CREATE TABLE "medical_histories"(
    "id" INTEGER NULL,
    "admitted_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "patient_id" INTEGER NOT NULL,
    "status" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "medical_histories" ADD PRIMARY KEY("id");
CREATE TABLE "treatments"(
    "id" INTEGER NULL,
    "type" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "treatments" ADD PRIMARY KEY("id");
CREATE TABLE "invoice_items"(
    "id" INTEGER NULL,
    "unit_price" DECIMAL(8, 2) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_price" DECIMAL(8, 2) NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "treatment_id" INTEGER NOT NULL
);
ALTER TABLE
    "invoice_items" ADD PRIMARY KEY("id");
CREATE TABLE "treatment_history" (
  treatment_id INT,
  medical_history_id INT,
);
ALTER TABLE
    "invoices" ADD CONSTRAINT "invoices_medical_history__id_foreign" FOREIGN KEY("medical_history__id") REFERENCES "medical_histories"("id");
ALTER TABLE
    "invoice_items" ADD CONSTRAINT "invoice_items_invoice_id_foreign" FOREIGN KEY("invoice_id") REFERENCES "invoices"("id");
ALTER TABLE
    "medical_histories" ADD CONSTRAINT "medical_histories_patient_id_foreign" FOREIGN KEY("patient_id") REFERENCES "patients"("id");
ALTER TABLE
    "invoice_items" ADD CONSTRAINT "invoice_items_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");
ALTER TABLE
    "treatment_history" ADD CONSTRAINT "treatment_history_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");
ALTER TABLE
    "treatment_history" ADD CONSTRAINT "treatment_history_medical_history__id_foreign" FOREIGN KEY("medical_history__id") REFERENCES "medical_histories"("id");


CREATE INDEX medical_history__id_idx ON invoices(medical_history__id);
CREATE INDEX patient_id_idx ON medical_histories(patient_id);
CREATE INDEX invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX treatment_id_idx ON invoice_items(treatment_id);
CREATE INDEX treatment_id_idx ON treatment_history(treatment_id);
CREATE INDEX medical_history_id_idx ON treatment_history(medical_history_id);