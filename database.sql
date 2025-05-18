-- Table des utilisateurs
CREATE TABLE public."User" (
    id_user integer NOT NULL DEFAULT nextval('public."User_id_seq"'::regclass),
    pseudo character varying(50) NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    birthday date,
    sex character(1),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    last_auth timestamp(6) without time zone,
    CONSTRAINT "USER_pkey" PRIMARY KEY (id_user),
    CONSTRAINT "User_email_key" UNIQUE (email),
    CONSTRAINT "User_pseudo_key1" UNIQUE (pseudo)
);

-- Table des exercices
CREATE TABLE public."Exercice" (
    id_exercice integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    title character varying(50) NOT NULL,
    description text,
    public boolean DEFAULT false NOT NULL,
    id_user integer NOT NULL,
    CONSTRAINT "Exercice_pkey" PRIMARY KEY (id_exercice),
    CONSTRAINT user_id_fkey FOREIGN KEY (id_user) REFERENCES public."User"(id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table des séances
CREATE TABLE public."Seance" (
    id_seance integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    id_user integer NOT NULL,
    title character varying(15) NOT NULL,
    date timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    objective text,
    CONSTRAINT seance_pkey PRIMARY KEY (id_seance),
    CONSTRAINT user_id_fkey FOREIGN KEY (id_user) REFERENCES public."User"(id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table des Exercices associés à une séance
CREATE TABLE public."ExerciceStats" (
    id_exercice_stats integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    id_exercice integer NOT NULL,
    id_seance integer NOT NULL,
    reps integer NOT NULL,
    weight numeric(5,1) NOT NULL,
    sets integer NOT NULL,
    CONSTRAINT "ExerciceStats_pkey" PRIMARY KEY (id_exercice_stats),
    CONSTRAINT exercice_id_fkey FOREIGN KEY (id_exercice) REFERENCES public."Exercice"(id_exercice) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT seance_id_fkey FOREIGN KEY (id_seance) REFERENCES public."Seance"(id_seance) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table des données physiques
CREATE TABLE public."PhysicalData" (
    id_physical_data integer NOT NULL DEFAULT nextval('public."PhysicalData_id_physical_data_seq"'::regclass),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    height integer NOT NULL,
    weight numeric(5,1) NOT NULL,
    id_user integer NOT NULL,
    CONSTRAINT "PhysicalData_pkey" PRIMARY KEY (id_physical_data),
    CONSTRAINT user_id_fkey FOREIGN KEY (id_user) REFERENCES public."User"(id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table des clés de réinitialisation de mot de passe
CREATE TABLE public."ResetPasswordKey" (
    id_reset_password_key integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    key character varying(100) NOT NULL,
    id_user integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "ResetPasswordKey_pkey" PRIMARY KEY (id_reset_password_key),
    CONSTRAINT user_id_fkey FOREIGN KEY (id_user) REFERENCES public."User"(id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Index pour l'email et le pseudo
CREATE UNIQUE INDEX "USER_email_key" ON public."User" USING btree (email);
CREATE UNIQUE INDEX "User_pseudo_key" ON public."User" USING btree (pseudo);