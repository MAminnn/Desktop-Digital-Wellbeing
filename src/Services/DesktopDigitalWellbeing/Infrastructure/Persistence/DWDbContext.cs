﻿using Domain.POCOs.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Sqlite;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Persistence
{
    public class DWDbContext : DbContext
    {
        private readonly IConfigurationRoot configuration =
            new ConfigurationBuilder().AddJsonFile(path: Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json")
                , optional: true, reloadOnChange: true)
            .Build();
        public DbSet<Application> Applications { get; set; }
        public DbSet<ApplicationStat> ApplicationStats { get; set; }
        public DbSet<Day> Days { get; set; }

        public DWDbContext()
        {

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //optionsBuilder.UseSqlite(configuration.GetConnectionString("SqliteDB"));
            optionsBuilder.UseSqlite(@"DataSource = Z:\Projects\Productions\Desktop Digital Wellbeing\src\Services\DesktopDigitalWellbeing\Infrastructure\Database\DWDatabase.db");
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Application>().HasKey(a => a.ID);
            modelBuilder.Entity<Application>().Property(a => a.Path).HasAnnotation("Required", true);

            modelBuilder.Entity<Day>().HasKey(d=>d.DateTime);
            //modelBuilder.Entity<Day>().HasMany<ApplicationStat>(d => d.ApplicationsStats).WithOne(appst => appst.Day).HasForeignKey(appst => appst.DayDate).HasPrincipalKey(d=>d.DateTime);

            modelBuilder.Entity<ApplicationStat>().HasOne<Application>(appst => appst.Application).WithMany();
            modelBuilder.Entity<ApplicationStat>().HasOne<Day>(appst => appst.Day).WithMany(d=>d.ApplicationsStats);

            modelBuilder.Entity<ApplicationStat>().HasKey(appst=>new
            {
                appst.ApplicationId,
                appst.DayDate
            });
            base.OnModelCreating(modelBuilder);
        }
    }
}
